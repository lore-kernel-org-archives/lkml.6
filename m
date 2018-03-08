Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934683AbeCHB5R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:57:17 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39272 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933351AbeCHB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:57:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Sz3vfU8_1520474222;
Subject: Re: [PATCH 3/4] module: Support to show the current enforcement
 policy
To: Jessica Yu <jeyu@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1519895346-7961-3-git-send-email-zhang.jia@linux.alibaba.com>
 <20180307201408.ssuzsmbatntk67yz@redbean>
From: Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <a4393541-5240-3924-8d29-3449ddf616d8@linux.alibaba.com>
Date: Thu, 8 Mar 2018 09:57:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307201408.ssuzsmbatntk67yz@redbean>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/3/8 上午4:14, Jessica Yu wrote:
> +++ Jia Zhang [01/03/18 17:09 +0800]:
>> /sys/kernel/security/modsign/enforce gives the result of current
>> enforcement policy of loading module.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> 
> Why is this being added as part of securityfs? AFAIK that's primarily
> used by LSMs.

The integrity subsystem such as IMA is also located there.

> 
> And we already export sig_enforce to sysfs (See
> /sys/module/module/parameters/sig_enforce).
> It already does exactly what your patchset tries to do, it only allows
> for enablement.

I will respond this in V2.

Thanks,
Jia

> Jessica
> 
>> ---
>> kernel/module.c | 55
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 55 insertions(+)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 79825ea..e3c6c8e 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2794,11 +2794,60 @@ static int module_sig_check(struct load_info
>> *info, int flags)
>>
>>     return err;
>> }
>> +
>> +#ifdef CONFIG_SECURITYFS
>> +static ssize_t modsign_enforce_read(struct file *filp, char __user
>> *ubuf,
>> +                    size_t count, loff_t *offp)
>> +{
>> +    char buf[2];
>> +
>> +    sprintf(buf, "%d", !!sig_enforce);
>> +
>> +    return simple_read_from_buffer(ubuf, count, offp, buf, 1);
>> +}
>> +
>> +static const struct file_operations modsign_enforce_ops = {
>> +    .read = modsign_enforce_read,
>> +    .llseek = generic_file_llseek,
>> +};
>> +
>> +static int __init securityfs_init(void)
>> +{
>> +    struct dentry *modsign_dir;
>> +    struct dentry *enforce;
>> +
>> +    modsign_dir = securityfs_create_dir("modsign", NULL);
>> +    if (IS_ERR(modsign_dir))
>> +        return -1;
>> +
>> +    enforce = securityfs_create_file("enforce",
>> +                     S_IRUSR | S_IRGRP, modsign_dir,
>> +                     NULL, &modsign_enforce_ops);
>> +    if (IS_ERR(enforce))
>> +        goto out;
>> +
>> +    return 0;
>> +out:
>> +    securityfs_remove(modsign_dir);
>> +
>> +    return -1;
>> +}
>> +#else /* !CONFIG_SECURITYFS */
>> +static int __init securityfs_init(void)
>> +{
>> +    return 0;
>> +}
>> +#endif
>> #else /* !CONFIG_MODULE_SIG */
>> static int module_sig_check(struct load_info *info, int flags)
>> {
>>     return 0;
>> }
>> +
>> +static int __init securityfs_init(void)
>> +{
>> +    return 0;
>> +}
>> #endif /* !CONFIG_MODULE_SIG */
>>
>> /* Sanity checks against invalid binaries, wrong arch, weird elf
>> version. */
>> @@ -4395,8 +4444,14 @@ void module_layout(struct module *mod,
>>
>> static int __init initialize_module(void)
>> {
>> +    int ret;
>> +
>>     proc_modules_init();
>>
>> +    ret = securityfs_init();
>> +    if (unlikely(ret))
>> +        return ret;
>> +
>>     return 0;
>> }
>> module_init(initialize_module);
>> -- 
>> 1.8.3.1
>>
