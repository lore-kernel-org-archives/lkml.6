Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934441AbeBLMQm convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:16:42 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36206 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933136AbeBLMQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:16:41 -0500
X-Google-Smtp-Source: AH8x227sSDR8QbtWA8VTAjnfeKze/xa07DS9dJqC3o0hfkY5qpsLoxL2afKxO5ORQIJaqYlSOshLCMgxUgzxKn16lpc=
MIME-Version: 1.0
In-Reply-To: <20180212052710-mutt-send-email-mst@kernel.org>
References: <20180207013525.1634-1-marcandre.lureau@redhat.com>
 <20180207013525.1634-5-marcandre.lureau@redhat.com> <20180212052710-mutt-send-email-mst@kernel.org>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 12 Feb 2018 13:16:40 +0100
Message-ID: <CAMxuvays1pmjj692sV+Utax2ttzeMMh_NunS=v5ogb5K7+kKng@mail.gmail.com>
Subject: Re: [PATCH v13 4/4] RFC: fw_cfg: do DMA read operation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Feb 12, 2018 at 4:30 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Feb 07, 2018 at 02:35:25AM +0100, Marc-André Lureau wrote:
>> Modify fw_cfg_read_blob() to use DMA if the device supports it.
>> Return errors, because the operation may fail.
>>
>> So far, only one call in fw_cfg_register_dir_entries() is using
>> kmalloc'ed buf and is thus clearly eligible to DMA read.
>>
>> Initially, I didn't implement DMA read to speed up boot time, but as a
>> first step before introducing DMA write (since read operations were
>> already presents). Even more, I didn't realize fw-cfg entries were
>> being read by the kernel during boot by default. But actally fw-cfg
>> entries are being populated during module probe. I knew DMA improved a
>> lot bios boot time (the main reason the DMA interface was added
>> afaik). Let see the time it would take to read the whole ACPI
>> tables (128kb allocated)
>>
>>  # time cat /sys/firmware/qemu_fw_cfg/by_name/etc/acpi/tables/raw
>>   - with DMA: sys 0m0.003s
>>   - without DMA (-global fw_cfg.dma_enabled=off): sys 0m7.674s
>>
>> FW_CFG_FILE_DIR (0x19) is the only "file" that is read during kernel
>> boot to populate sysfs qemu_fw_cfg directory, and it is quite
>> small (1-2kb). Since it does not expose itself, in order to measure
>> the time it takes to read such small file, I took a comparable sized
>> file of 2048 bytes and exposed it (-fw_cfg test,file=file with a
>> modified read_raw enabling DMA)
>>
>>  # perf stat -r 100 cat /sys/firmware/qemu_fw_cfg/by_name/test/raw >/dev/null
>>   - with DMA:
>>           0.636037      task-clock (msec)         #    0.141 CPUs utilized            ( +-  1.19% )
>>   - without DMA:
>>           6.430128      task-clock (msec)         #    0.622 CPUs utilized            ( +-  0.22% )
>>
>> That's a few msec saved during boot by enabling DMA read (the gain
>> would be more substantial if other & bigger fw-cfg entries are read by
>> others from sysfs, unfortunately, it's not clear if we can always
>> enable DMA there)
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  drivers/firmware/qemu_fw_cfg.c | 47 ++++++++++++++++++++++++++++++------------
>>  1 file changed, 34 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
>> index fd576ba7b337..3721dc868a2b 100644
>> --- a/drivers/firmware/qemu_fw_cfg.c
>> +++ b/drivers/firmware/qemu_fw_cfg.c
>> @@ -150,11 +150,13 @@ static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
>>  }
>>
>>  /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
>> -static inline void fw_cfg_read_blob(u16 key,
>> -                                 void *buf, loff_t pos, size_t count)
>> +static ssize_t fw_cfg_read_blob(u16 key,
>> +                             void *buf, loff_t pos, size_t count,
>> +                             bool dma)
>>  {
>>       u32 glk = -1U;
>>       acpi_status status;
>> +     ssize_t ret = count;
>>
>>       /* If we have ACPI, ensure mutual exclusion against any potential
>>        * device access by the firmware, e.g. via AML methods:
>> @@ -164,17 +166,36 @@ static inline void fw_cfg_read_blob(u16 key,
>>               /* Should never get here */
>>               WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
>>               memset(buf, 0, count);
>> -             return;
>> +             return -EINVAL;
>>       }
>>
>>       mutex_lock(&fw_cfg_dev_lock);
>> -     iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
>> -     while (pos-- > 0)
>> -             ioread8(fw_cfg_reg_data);
>> -     ioread8_rep(fw_cfg_reg_data, buf, count);
>> +     if (dma && fw_cfg_dma_enabled()) {
>> +             if (pos == 0) {
>> +                     ret = fw_cfg_dma_transfer(buf, count, key << 16
>> +                                               | FW_CFG_DMA_CTL_SELECT
>> +                                               | FW_CFG_DMA_CTL_READ);
>> +             } else {
>> +                     iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
>> +                     ret = fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
>> +                     if (ret < 0)
>> +                             goto end;
>> +                     ret = fw_cfg_dma_transfer(buf, count,
>> +                                               FW_CFG_DMA_CTL_READ);
>> +             }
>> +     } else {
>> +             iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
>> +             while (pos-- > 0)
>> +                     ioread8(fw_cfg_reg_data);
>> +             ioread8_rep(fw_cfg_reg_data, buf, count);
>> +     }
>> +
>> +end:
>>       mutex_unlock(&fw_cfg_dev_lock);
>>
>>       acpi_release_global_lock(glk);
>> +
>> +     return ret;
>>  }
>>
>
> These two functions share no common code at all.
> Pls name the dma one fw_cfg_dma_read or something like this,
> cleaner than a flag.

They share arguments, ACPI locking, error handling, cleanup. But they
also allow to abstract read over dma-capable and non-dma capable. I'll
split both cases in two functions.

>
>>  #ifdef CONFIG_CRASH_CORE
>> @@ -307,7 +328,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>>  #endif
>>
>>       /* verify fw_cfg device signature */
>> -     fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
>> +     fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE, false);
>>       if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) != 0) {
>>               fw_cfg_io_cleanup();
>>               return -ENODEV;
>
> BTW it looks like fw_cfg_read_blob can fail and that failure isn't
> handled properly here.

ok

>
>> @@ -494,8 +515,8 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
>>       if (count > entry->f.size - pos)
>>               count = entry->f.size - pos;
>>
>> -     fw_cfg_read_blob(entry->f.select, buf, pos, count);
>> -     return count;
>> +     /* do not use DMA, virt_to_phys(buf) might not be ok */
>> +     return fw_cfg_read_blob(entry->f.select, buf, pos, count, false);
>>  }
>>
>>  static struct bin_attribute fw_cfg_sysfs_attr_raw = {
>> @@ -656,7 +677,7 @@ static int fw_cfg_register_dir_entries(void)
>>       struct fw_cfg_file *dir;
>>       size_t dir_size;
>>
>> -     fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count));
>> +     fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count), false);
>>       count = be32_to_cpu(count);
>>       dir_size = count * sizeof(struct fw_cfg_file);
>>
>> @@ -664,7 +685,7 @@ static int fw_cfg_register_dir_entries(void)
>>       if (!dir)
>>               return -ENOMEM;
>>
>> -     fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
>> +     fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size, true);
>>
>>       for (i = 0; i < count; i++) {
>>               dir[i].size = be32_to_cpu(dir[i].size);
>> @@ -713,7 +734,7 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>>               goto err_probe;
>>
>>       /* get revision number, add matching top-level attribute */
>> -     fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev));
>> +     fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev), false);
>>       fw_cfg_rev = le32_to_cpu(fw_cfg_rev);
>>       err = sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
>>       if (err)
>> --
>> 2.16.1.73.g5832b7e9f2
