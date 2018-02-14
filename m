Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033331AbeBNRIv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:08:51 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47044 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033141AbeBNRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:08:50 -0500
X-Google-Smtp-Source: AH8x224GMgg+qwv2pzkt9I0dqnti9Z7+K3Ywoug692irGCd87YY9zva2QQ607ZXYLn5hX9cEAZS1YgJ6pdPT7SJs66k=
MIME-Version: 1.0
In-Reply-To: <20180214185818-mutt-send-email-mst@kernel.org>
References: <20180214141850.4017-1-marcandre.lureau@redhat.com>
 <20180214141850.4017-10-marcandre.lureau@redhat.com> <20180214182714-mutt-send-email-mst@kernel.org>
 <CAMxuvaw8iUidXhFMO5gnUS56H+SncOzF71yaQpHNW4JnsYM3vQ@mail.gmail.com> <20180214185818-mutt-send-email-mst@kernel.org>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Wed, 14 Feb 2018 18:08:48 +0100
Message-ID: <CAMxuvaxC-JynbreyVet2KHNqWnuwqUyPyt-m3qjazW32c3e8Bg@mail.gmail.com>
Subject: Re: [PATCH v14 9/9] RFC: fw_cfg: do DMA read operation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Feb 14, 2018 at 5:59 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Feb 14, 2018 at 05:52:10PM +0100, Marc-Andre Lureau wrote:
>> >> @@ -282,8 +320,9 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>> >>  #endif
>> >>
>> >>       /* verify fw_cfg device signature */
>> >> -     fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
>> >> -     if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) != 0) {
>> >> +     if (fw_cfg_read_blob(FW_CFG_SIGNATURE, sig,
>> >> +                             0, FW_CFG_SIG_SIZE, false) < 0 ||
>> >> +             memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) != 0) {
>> >>               fw_cfg_io_cleanup();
>> >>               return -ENODEV;
>> >>       }
>> >
>> > Rather than add dead code, how about a promise not to
>> > fail if dma is disabled? Patch will be smaller then.
>>
>> Even with dma disabled, you could have a locking bug which was
>> silently ignored before and is now taken into account.
>
> I see. I'd start with a patch reporting errors to users then.
> That would be a bugfix and can be merged for this version.

silently is the wrong word for it, there is already a WARN(). However,
the memcmp was done on uninitialzed sig[] (which likely resulted in
returning -ENODEV in the function)

Now it can check if the function failed to read before doing the memcmp.

Hope that clarifies it.

>
>> >
>> >> @@ -466,8 +505,8 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
>> >>       if (count > entry->size - pos)
>> >>               count = entry->size - pos;
>> >>
>> >> -     fw_cfg_read_blob(entry->select, buf, pos, count);
>> >> -     return count;
>> >> +     /* do not use DMA, virt_to_phys(buf) might not be ok */
>> >> +     return fw_cfg_read_blob(entry->select, buf, pos, count, false);
>> >>  }
>> >>
>> >>  static struct bin_attribute fw_cfg_sysfs_attr_raw = {
>> >> @@ -632,7 +671,12 @@ static int fw_cfg_register_dir_entries(void)
>> >>       struct fw_cfg_file *dir;
>> >>       size_t dir_size;
>> >>
>> >> -     fw_cfg_read_blob(FW_CFG_FILE_DIR, &files.count, 0, sizeof(files.count));
>> >> +     ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, &files.count,
>> >> +                     0, sizeof(files.count), false);
>> >> +     if (ret < 0) {
>> >> +             return ret;
>> >> +     }
>> >> +
>> >>       count = be32_to_cpu(files.count);
>> >>       dir_size = count * sizeof(struct fw_cfg_file);
>> >>
>> >> @@ -640,7 +684,11 @@ static int fw_cfg_register_dir_entries(void)
>> >>       if (!dir)
>> >>               return -ENOMEM;
>> >>
>> >> -     fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(files.count), dir_size);
>> >> +     ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, dir,
>> >> +                     sizeof(files.count), dir_size, false);
>> >> +     if (ret < 0) {
>> >> +             goto end;
>> >> +     }
>> >>
>> >>       for (i = 0; i < count; i++) {
>> >>               ret = fw_cfg_register_file(&dir[i]);
>> >> @@ -648,6 +696,7 @@ static int fw_cfg_register_dir_entries(void)
>> >>                       break;
>> >>       }
>> >>
>> >> +end:
>> >>       kfree(dir);
>> >>       return ret;
>> >>  }
>> >> @@ -688,7 +737,10 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>> >>               goto err_probe;
>> >>
>> >>       /* get revision number, add matching top-level attribute */
>> >> -     fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
>> >> +     err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev), false);
>> >> +     if (err < 0) {
>> >> +             goto err_probe;
>> >> +     }
>> >>       fw_cfg_rev = le32_to_cpu(rev);
>> >>       err = sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
>> >>       if (err)
>> >> --
>> >> 2.16.1.73.g5832b7e9f2
