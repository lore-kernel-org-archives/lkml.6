Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeDYKiN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:38:13 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeDYKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:38:07 -0400
Subject: Re: [PATCH] p9caps: add Plan9 capability devices
To: Richard Weinberger <richard.weinberger@gmail.com>,
        "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org>
 <20180211215028.16210-1-metux@gmx.de> <20180211215028.16210-2-metux@gmx.de>
 <CAFLxGvwHebXuQYwOdG_vnYfjwtdMfCHg5srzjsj1fEaCFm2QGw@mail.gmail.com>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <3ffb5399-46b8-7279-fda2-2ca5b40c04d3@metux.net>
Date: Wed, 25 Apr 2018 12:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwHebXuQYwOdG_vnYfjwtdMfCHg5srzjsj1fEaCFm2QGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YJApcYarjUecWghVs6AzDz/lfOLHLEAIma5jn73ju50QxgKsCZF
 hT36GfO8W1qncJSzPqnqYRZzj22brOIu5WdxtnK1NwG2UuPrZCp/xzOYBCyYjsIUgFS80yh
 qMRkLQ+S4TKxNd5AZAjULRsse+0jDYwJjYNs5jmzCN2mYhjeH/oIMKof4IoUgut/5hra136
 krNmoRn2cUoT21kZZxSKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o8ZhzSKPCiM=:ELdtN1Z0JXDY/zlYbSV8Lh
 llx4n16qQ3UqMXWFxZdlcrzcFP+Sy2eZa4SjSVbwZ1zO5ku4LhOXHazkxXia263pX685OVvta
 1UirY92j+glmNYx6j+zKpJ6ucxTaPnh78eZ9ShATYLWAnnRKQ1r5sdEwEF9KVitDXSHbn5FoG
 5R4d3hy5CEdukRVayrGC/aGtvwy79T7r/d1wnwXiPvHflM4T5mkRzfw/HdCPHKbb70l5GTYj4
 0wVov4VYNi7xfs/j/FX0aoHxiQ3IERRBlK7OFsJL2Dz8VNpoSH39PhmhUo42RS+fD5cQKYef7
 1fvvBbE0q9+8OGPZM2r3pcxDNcDt6VsfNDbqVzjgTqDNb7Q0AZ+W66PYNNaij4ypC4WqIKIZ6
 m4DuoMQBxzEU62XyLELGS3WdLHE5EfIB+mwv0JOV78e00Va0zVEQ1xDDThLazuarklYltiC6h
 aUBsrcMIpEXGMOPLl8gpe/iPHyoaACEawHRjy5biVEasphHdQrjokPaRRsDTrBtiO0dfTBmNA
 nZkTZeTbON1s/WgOM71XpV+L87B5dDFYZVz4dLwwz7WzeeOLm3RJZi8guyD/vgaIu0z9zoA74
 8zr6bSoXj1Rn4k6wfjgPuBDFRnUXEs9fMlYax8pzHBI0lnlHZ4XbxFat84bpEUZ0wkjHuEOwP
 uOwjyfFym0RbxriyPVbK/Udh01uNR7dIHn53xQfdo5JLdHuGxiUPLg0Az4OxGi2zDbbJ0ZAGo
 o/vFC8MDe8sJ5x6xXZ6SzcoKt+TxCYdLE8P7AruYOV4I6CKq2FWU50nh4bQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.2018 23:11, Richard Weinberger wrote:

Hi,

>> +static LIST_HEAD(caphash_writers); >> +>> +static DEFINE_MUTEX(lock);>> +>> +struct crypto_ahash *hmac_tfm 
= NULL;>> +>> +static int caphash_open(struct inode *inode, struct file 
*filp)>> +{>> +       struct caphash_writer *tmp = NULL;>> + 
struct user_namespace *user_ns = current_user_ns();>> +       int retval 
= 0;>> +       struct list_head *pos, *q;>> +>> +       /* make sure 
only one instance per namespace can be opened */>> + 
mutex_lock(&lock);>> +>> +       list_for_each_safe(pos, q, 
&(caphash_writers)) {>> +               tmp = list_entry(pos, struct 
caphash_writer, list);>> +               if (tmp->user_ns == user_ns) 
{>> +                       pr_err("already locked in this namespace\n");>
> So, evil guy opens the device but does not close it, therefore the
> whole service is blocked in a namespace?

Yes, exactly as specified. There may be only one host factotum running,
which can create caps. It's an important security feature.

> In general, I think we should open that device in
> kernel_init_freeable() and hand over the fd to init/systemd.

That would require an customized init and factotum, and wouldn't be
Plan9 compatible.

>> +static int caphash_release(struct inode *inode, struct file *filp)
>> +{
>> +       int retval = 0;
>> +       struct user_namespace *user_ns = current_user_ns();
> 
> Why not obtaining the user namespace from the open file?
> That way one can close a caphash file hande she never opened.
> Think of open, followed by nsenter, ...

hmm, good point.

>> +       list_for_each_safe(pos, q, &(caphash_writers)) {
>> +               tmp = list_entry(pos, struct caphash_entry, list);
> 
> list_for_each_entry.

what's the exact difference ?

>> +static ssize_t capuse_write(struct file *filp, const char __user *buf,
>> +                                 size_t count, loff_t *f_pos)
>> +{
>> +       ssize_t retval = count;
>> +       char  *rand_str, *src_uname, *dst_uname;
>> +       u8 hashval[SHA1_DIGEST_SIZE] = { 0 };
>> +       char *cmdbuf;
>> +
>> +       if (!(cmdbuf = kzalloc(count, GFP_KERNEL)))
> 
> count is unbound, please apply a limit check.

ok.

>> +       {
>> +               char *walk = cmdbuf;
> 
> cmdbuf is toxic, make sure it is at least nul-terminated.

ok.

>> +       if (hmac_tfm)
> 
> IS_ERR()? Otherwise you free a error value, if crypto_alloc_ahash() fails.

ok


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
