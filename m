Return-Path: <srivatsa@csail.mit.edu>
X-Google-Smtp-Source: AH8x227MWUPcFPrujUAaMz9HmtI/BSwXh/RGlKHXSBgaKt09H27GyQs36fRtMaq/WzdWZ1Do5FMs
ARC-Seal: i=1; a=rsa-sha256; t=1517947128; cv=none;
        d=google.com; s=arc-20160816;
        b=BI7bmufj/dMkMkaahI2WuQ5Rb5u+UdED6ffWATKdl6VUnjQFyFFMSW0by5IKpAjSwH
         UCR4+Qzt3YTGWVpVdCJXCpytG5IoC/70rdUnLm9TRYT45S3ZKfU/3LLvJG5niL+Oojih
         zjBR7lAyIehZgu/wKxgc9Gh0Bj2nfCMkXUbi1iJX0VI44/MU6oLPpaPzupqGCf0U7dST
         vPMKMFqBRAtdsIZCDTgGY/t4ogxrXZK/gE6kZlBoSEqjab/VWYndyNVll2DMgCbv25U2
         yTgxQgD0wQ0lIEV69Dk8ixYoD2gQ0VM8P+wAoerFBPM3vSwGuRbUmUPGtD5hK7WDAloq
         suRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=etizBiUAgk/58Uu+aljHkg7VB9Mh6CH+zOM2XhUW+H4=;
        b=HMyHmr/rmyNFbvtgeIYXW24b708AUuidy0gDRyvmg0kG1p/GRuTwVhk7PTidj+p/1H
         cY5ysfe+klZ77/KRRvkHMQrc1ei5lHRuKM0MZ4mj7Y+lqxUzFtPhGQAu/G5F3My4+eGC
         mpSGNZcPIEc//jWL3MFvtBDB+wG2UiHOFR6KpbynKXJ7RfcHKEzYBNDnUbUTVsoNAPWg
         OKaLGzFfvheqriQ1BTO2/surHv1UnoOx3Bxs+zXvWz3iTWwXMu1woish7+GtOypTmF96
         rbUrRN24jaTZhjQ/mYNasX1Yn7hEWp86Ob/zE7zTjxFl9dUFUqC0FrR7fMKQU9a35k1b
         sRNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Subject: Re: [PATCH 2/2] block, char_dev: Use correct format specifier for
 unsigned ints
To: Greg KH <gregkh@linuxfoundation.org>
Cc: logang@deltatee.com, axboe@kernel.dk, jlayton@poochiereds.net,
 bfields@fieldses.org, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
 <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
 <20180206102421.GC7889@kroah.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <4ed3b9d5-ea65-ef7d-6377-62aeae44c5a3@csail.mit.edu>
Date: Tue, 6 Feb 2018 11:58:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206102421.GC7889@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591616659826839373?=
X-GMAIL-MSGID: =?utf-8?q?1591682928963023816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/6/18 2:24 AM, Greg KH wrote:
> On Mon, Feb 05, 2018 at 06:25:27PM -0800, Srivatsa S. Bhat wrote:
>> From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
>>
>> register_blkdev() and __register_chrdev_region() treat the major
>> number as an unsigned int. So print it the same way to avoid
>> absurd error statements such as:
>> "... major requested (-1) is greater than the maximum (511) ..."
>> (and also fix off-by-one bugs in the error prints).
>>
>> While at it, also update the comment describing register_blkdev().
>>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
>> ---
>>
>>  block/genhd.c |   19 +++++++++++--------
>>  fs/char_dev.c |    4 ++--
>>  2 files changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 88a53c1..21a18e5 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -308,19 +308,22 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
>>  /**
>>   * register_blkdev - register a new block device
>>   *
>> - * @major: the requested major device number [1..255]. If @major = 0, try to
>> - *         allocate any unused major number.
>> + * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
>> + *         @major = 0, try to allocate any unused major number.
>>   * @name: the name of the new block device as a zero terminated string
>>   *
>>   * The @name must be unique within the system.
>>   *
>>   * The return value depends on the @major input parameter:
>>   *
>> - *  - if a major device number was requested in range [1..255] then the
>> - *    function returns zero on success, or a negative error code
>> + *  - if a major device number was requested in range [1..BLKDEV_MAJOR_MAX-1]
>> + *    then the function returns zero on success, or a negative error code
>>   *  - if any unused major number was requested with @major = 0 parameter
>>   *    then the return value is the allocated major number in range
>> - *    [1..255] or a negative error code otherwise
>> + *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise
>> + *
>> + * See Documentation/admin-guide/devices.txt for the list of allocated
>> + * major numbers.
>>   */
>>  int register_blkdev(unsigned int major, const char *name)
>>  {
>> @@ -347,8 +350,8 @@ int register_blkdev(unsigned int major, const char *name)
>>  	}
>>  
>>  	if (major >= BLKDEV_MAJOR_MAX) {
>> -		pr_err("register_blkdev: major requested (%d) is greater than the maximum (%d) for %s\n",
>> -		       major, BLKDEV_MAJOR_MAX, name);
>> +		pr_err("register_blkdev: major requested (%u) is greater than the maximum (%u) for %s\n",
>> +		       major, BLKDEV_MAJOR_MAX-1, name);
>>  
>>  		ret = -EINVAL;
>>  		goto out;
>> @@ -375,7 +378,7 @@ int register_blkdev(unsigned int major, const char *name)
>>  		ret = -EBUSY;
>>  
>>  	if (ret < 0) {
>> -		printk("register_blkdev: cannot get major %d for %s\n",
>> +		printk("register_blkdev: cannot get major %u for %s\n",
>>  		       major, name);
>>  		kfree(p);
>>  	}
>> diff --git a/fs/char_dev.c b/fs/char_dev.c
>> index 33c9385..a279c58 100644
>> --- a/fs/char_dev.c
>> +++ b/fs/char_dev.c
>> @@ -121,8 +121,8 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>>  	}
>>  
>>  	if (major >= CHRDEV_MAJOR_MAX) {
>> -		pr_err("CHRDEV \"%s\" major requested (%d) is greater than the maximum (%d)\n",
>> -		       name, major, CHRDEV_MAJOR_MAX);
>> +		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum (%u)\n",
>> +		       name, major, CHRDEV_MAJOR_MAX-1);
>>  		ret = -EINVAL;
>>  		goto out;
>>  	}
> 
> Thanks for both of these patches, if Al doesn't grab them, I will after
> 4.16-rc1 comes out.
> 

Sounds great! Thank you!

Regards,
Srivatsa
