Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeBBJnt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:43:49 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43466 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBBJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:43:45 -0500
X-Google-Smtp-Source: AH8x225iDHEIk0cjLKY1GMlPMmERf7KTvzei7Azyp8/6VGrAfE8dgv28Hk2vK4XBE2hfLtwdUmUae69kxrLhIRqVKYA=
MIME-Version: 1.0
In-Reply-To: <20180202044330-mutt-send-email-mst@kernel.org>
References: <20180201130300.9962-1-marcandre.lureau@redhat.com>
 <20180201130300.9962-5-marcandre.lureau@redhat.com> <20180202044330-mutt-send-email-mst@kernel.org>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Fri, 2 Feb 2018 10:43:44 +0100
Message-ID: <CAMxuvaxL5sGU9GAsdCX1bFhECUOF08ojcDBJ_bYDF2xaZU45pA@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] fw_cfg: write vmcoreinfo details
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

On Fri, Feb 2, 2018 at 3:44 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Feb 01, 2018 at 02:03:00PM +0100, Marc-André Lureau wrote:
>> @@ -314,6 +359,37 @@ struct fw_cfg_sysfs_entry {
>>       struct device *dev;
>>  };
>>
>> +#ifdef CONFIG_CRASH_CORE
>> +static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_file *f)
>> +{
>> +     struct vmci {
>> +             __le16 host_format;
>> +             __le16 guest_format;
>> +             __le32 size;
>> +             __le64 paddr;
>> +     } __packed;
>> +     static struct vmci *data;
>> +     ssize_t ret;
>> +
>> +     data = kmalloc(sizeof(struct vmci), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     *data = (struct vmci) {
>> +             .guest_format = cpu_to_le16(VMCOREINFO_FORMAT_ELF),
>> +             .size = cpu_to_le32(VMCOREINFO_NOTE_SIZE),
>> +             .paddr = cpu_to_le64(paddr_vmcoreinfo_note())
>> +     };
>> +     /* spare ourself reading host format support for now since we
>> +      * don't know what else to format - host may ignore ours
>> +      */
>> +     ret = fw_cfg_write_blob(dev, f->select, data, 0, sizeof(struct vmci));
>> +
>> +     kfree(data);
>> +     return ret;
>> +}
>> +#endif /* CONFIG_CRASH_CORE */
>> +
>>  /* get fw_cfg_sysfs_entry from kobject member */
>>  static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj)
>>  {
>
> kmalloc during crash is I think a bad idea.
> How about preallocating on probe?

It doesn't kmalloc during crash, it kmalloc during boot. As such, I
don't see a reason to change it.

>
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 33e0256..ffd81d1 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -363,22 +363,33 @@ struct fw_cfg_sysfs_entry {
>  };
>
>  #ifdef CONFIG_CRASH_CORE
> +
> +struct vmci {
> +       __le16 host_format;
> +       __le16 guest_format;
> +       __le32 size;
> +       __le64 paddr;
> +} *fw_cfg_vmcore_data;
> +
> +static int fw_cfg_vmcore_init(void)
> +{
> +       fw_cfg_vmcore_data = kmalloc(sizeof(*fw_cfg_vmcore_data), GFP_KERNEL);
> +       if (!fw_cfg_vmcore_data)
> +               return -ENOMEM;
> +       return 0;
> +}
> +
> +static int fw_cfg_vmcore_cleanup(void)
> +{
> +       kfree(fw_cfg_vmcore_data);
> +}
> +
>  static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_file *f)
>  {
> -       struct vmci {
> -               __le16 host_format;
> -               __le16 guest_format;
> -               __le32 size;
> -               __le64 paddr;
> -       } __packed;
>         static struct vmci *data;
>         ssize_t ret;
>
> -       data = kmalloc(sizeof(struct vmci), GFP_KERNEL);
> -       if (!data)
> -               return -ENOMEM;
> -
> -       *data = (struct vmci) {
> +       *fw_cfg_vmcore_data = (struct vmci) {
>                 .guest_format = cpu_to_le16(VMCOREINFO_FORMAT_ELF),
>                 .size = cpu_to_le32(VMCOREINFO_NOTE_SIZE),
>                 .paddr = cpu_to_le64(paddr_vmcoreinfo_note())
> @@ -386,11 +397,23 @@ static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_file *f)
>         /* spare ourself reading host format support for now since we
>          * don't know what else to format - host may ignore ours
>          */
> -       ret = fw_cfg_write_blob(dev, f->select, data, 0, sizeof(struct vmci));
> +       ret = fw_cfg_write_blob(dev, f->select, fw_cfg_vmcore_data, 0,
> +                               sizeof(*fw_cfg_vmcore_data));
>
> -       kfree(data);
>         return ret;
>  }
> +
> +#else
> +
> +static int fw_cfg_vmcore_init(void)
> +{
> +       return 0;
> +}
> +
> +static int fw_cfg_vmcore_cleanup(void)
> +{
> +}
> +
>  #endif /* CONFIG_CRASH_CORE */
>
>  /* get fw_cfg_sysfs_entry from kobject member */
> @@ -725,11 +748,15 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>         if (fw_cfg_sel_ko)
>                 return -EBUSY;
>
> +       err = fw_cfg_vmcore_init();
> +       if (err)
> +               goto err_sel;
> +
>         /* create by_key and by_name subdirs of /sys/firmware/qemu_fw_cfg/ */
>         err = -ENOMEM;
>         fw_cfg_sel_ko = kobject_create_and_add("by_key", fw_cfg_top_ko);
>         if (!fw_cfg_sel_ko)
> -               goto err_sel;
> +               goto err_vmcore;
>         fw_cfg_fname_kset = kset_create_and_add("by_name", NULL, fw_cfg_top_ko);
>         if (!fw_cfg_fname_kset)
>                 goto err_name;
> @@ -764,6 +791,8 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>         fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
>  err_name:
>         fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
> +err_vmcore:
> +       fw_cfg_vmcore_cleanup();
>  err_sel:
>         return err;
>  }
> @@ -776,6 +805,7 @@ static int fw_cfg_sysfs_remove(struct platform_device *pdev)
>         fw_cfg_io_cleanup();
>         fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
>         fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
> +       fw_cfg_vmcore_cleanup();
>         return 0;
>  }
>
