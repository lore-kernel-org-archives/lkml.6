Return-Path: <srivatsa@csail.mit.edu>
X-Google-Smtp-Source: AH8x227mrYcm0e4Fb6EORkLCvjJ92xXAgRgprfJy2k00L0eCI6GFEFUlm3EHTl5xLKFBfcwIBAKM
ARC-Seal: i=1; a=rsa-sha256; t=1517531006; cv=none;
        d=google.com; s=arc-20160816;
        b=0RxAAEBOyUR1+U6QyvBJosi+Oal20BxzpuGTjE92EfKkWj2MF2Jt22exrp0VhDoWXX
         MGEQjO+xdTdZsNgCJ/YjrmKJ49y8Pte25rVSnf3JZazJPsicEJuj+q0OlOr0x0J++KBl
         cWj/TGSy3OGzpgLMqgMNVjieFd78WeOy24DaJqNTstiKY5JRUYqQcqKuhz7/QMmNwLSn
         A2VZntoy8+DCM0961ySsQT7xc8gt7Md+c2adhIc1+BetovsijFJrQ+chtPw7wrMsUN9k
         3+tUkvMi9Jdan1THN0CdABTrf+xtXPIBTr0iw3gVIDjpzhOCKaaAmL3ABAYNDWuYJitK
         h4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=yA5KfEKHqVSdffdYSaFlJ09b318HNvr9o4CQpRaCWjg=;
        b=EZy0Td8gGqLtQEqkmpkltysf9rc3a9lo6jIwSbTz3TCngr9IEQVPgKisaOk+PNMDhW
         Tnv75XZ9O4bWNbuPosrj7a8umDAGrudF2hgofthQIe1kdZUbt5Pl7KKhtJ+xPCI/Wh2G
         FV/1UGw0ilDeJXEM3g6Q4zW4u8uZ4ZrXsMjwJXco8ficI1dVv+nnJzC06eMWN4md//OS
         NPmj5IWO16owDEzg6em4GB07AQdivyWsDWxDM/uq3GSYS2u3U49+F1tA5dEz8f7Zh9yA
         k1NC5oV5N58yUx3j5gTut5hZMa+nN9KrGA7lTCnNhnM+ZeOfKoVu6XIPB6yC9Y6jrqlc
         n7Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Subject: Re: Change in register_blkdev() behavior
To: Logan Gunthorpe <logang@deltatee.com>, gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 linux-kernel@vger.kernel.org
References: <a01cedbc-ca1a-3e3d-cf2c-3e995c63f793@csail.mit.edu>
 <ce6d8040-3a1e-4137-e7b1-2066b9e56f42@deltatee.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <e23b4d8f-9391-d214-e370-548244339cfb@csail.mit.edu>
Date: Thu, 1 Feb 2018 16:23:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ce6d8040-3a1e-4137-e7b1-2066b9e56f42@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591067494565207085?=
X-GMAIL-MSGID: =?utf-8?q?1591246592344216284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Logan,

On 1/30/18 5:26 PM, Logan Gunthorpe wrote:
> 
> 
> On 30/01/18 05:56 PM, Srivatsa S. Bhat wrote:
>> If the restriction on the major number was intentional, perhaps we
>> should get the LTP testcase modified for kernel versions >= 4.14.
>> Otherwise, we should fix register_blkdev to preserve the old behavior.
>> (I guess the same thing applies to commit 8a932f73e5b "char_dev: order
>> /proc/devices by major number" as well).
> 
> The restriction was put in place so the code that prints the devices doesn't have to run through every integer in order to print the devices in order.
> 
> Given the existing documented fixed numbers in [1] and that future new char devices should be using dynamic allocation, this seemed like a reasonable restriction.
> 
> It would be pretty trivial to increase the limit but, IMO, setting it to UINT_MAX seems a bit much. Especially given that a lot of the documentation and code still very much has remnants of the 256 limit. (The series that included this patch only just expanded the char dynamic range to  above 256). So, I'd suggest the LTP test should change.
> 

Sounds good! Thank you!

By the way, I happened to notice a few minor issues with the
find_dynamic_major() function added by this patch series:

static int find_dynamic_major(void)
{
        int i;
        struct char_device_struct *cd;

        for (i = ARRAY_SIZE(chrdevs)-1; i > CHRDEV_MAJOR_DYN_END; i--) {
                                         ^^^^
As far as I can see, _DYN_END is inclusive, so shouldn't this be >= ?

                if (chrdevs[i] == NULL)
                        return i;
        }

        for (i = CHRDEV_MAJOR_DYN_EXT_START;
             i > CHRDEV_MAJOR_DYN_EXT_END; i--) {
              ^^^^
Same here; I believe this should be >=

                for (cd = chrdevs[major_to_index(i)]; cd; cd = cd->next)
                        if (cd->major == i)
                                break;

                if (cd == NULL || cd->major != i)
                                     ^^^^^^^^
It seems that this latter condition is unnecessary, as it will never be
true. (We'll reach here only if cd == NULL or cd->major == i).

                        return i;
        }

        return -EBUSY;
}

Regards,
Srivatsa
