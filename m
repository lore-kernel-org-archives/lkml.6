Return-Path: <kernel-hardening-return-12425-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsjtpVm4oz8bOlvGEbtZcNpv3GSxt4ys78WGlHN7GYE0aI+PviGCVjh7gA+SEevTjHsDi2W
ARC-Seal: i=1; a=rsa-sha256; t=1520849515; cv=none;
        d=google.com; s=arc-20160816;
        b=h95eJ6HNnLZst3PHWUAi8vJFw35RR6B9gtF/o4Y5Gix+kJmJTYD75alI+NmJrrG9+R
         K35oDqA4miuhMiPowPZNssWTBLsUXYVK0oCcduolCzoBH9mgcsO+S8y2g7mpJNZ1vefs
         /ZvRVh2zJNJXWydJ/2w/uCI1J0EMJ/1hDTJ246vg1CFphZdexX7SIWYrcRshDD/mUGah
         ivyIjTy73ft0c9DI04P8FXwJBMFKX7Lu68O/9hUMHdqzugj/0VF8J15NxKSVeBiHbei+
         Lw/O5yM+ub2Pc+KS6nEkqkbwswcV47q05V1PD7pcXojyzVzGw5xZeYfBzhQZxLvQ/8cy
         LZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=kuOynbi+Zn8wyAPGneNLjGjjo5vuHA1sBOSU+sBwZ9Q=;
        b=AD15l/MtptIL2mpNn3NRMy0wfJXIt3SlsgLBbAIvRJDIFcz/Jsm7GZVDbGhwdHE7yb
         2Xyyqy8Wz4Kwv0ZIMtDGi0t2bCRzYwTah9aJCKy42GaSYEZNAB64Qj7N3yGf428CanQP
         wWIl0DOHwnQc0qwTpyDOMQ3C5zqh50I+8W7hyU9EpZmFmWwMRLr9srpCPN6v17BFoTtX
         ba95fQagKZc2IZ59+jjvUdNj3ZY6KCtRJzh5PCjotvC9nOyx9JXcfbp9dp6GHuvihzQ3
         spjuxwbNlnM4iPL+jfHqfcmTT6Hz5Ot5bxrKA8Z/toLPZYs+GGXfkG9+7cfSbZh71OPL
         aw/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Tmuk+JvM;
       spf=pass (google.com: domain of kernel-hardening-return-12425-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12425-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Tmuk+JvM;
       spf=pass (google.com: domain of kernel-hardening-return-12425-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12425-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180312030834.GC8631@eros>
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com> <20180312030834.GC8631@eros>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 12 Mar 2018 11:11:15 +0100
Message-ID: <CAJHCu1KGAmuayemK-KxW7djNJ-asO8pG=6Yt9D=129rhTrhKLA@mail.gmail.com>
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
To: "Tobin C. Harding" <tobin@apporbit.com>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Dario Ballabio <ballabio_dario@emc.com>, Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594676969721761588?=
X-GMAIL-MSGID: =?utf-8?q?1594726301387096032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-12 4:08 GMT+01:00 Tobin C. Harding <tobin@apporbit.com>:
> Adding kernel newbies to CC because I pose a few noob questions :)
> Adding Linus to CC because I quoted him.
>
> On Sun, Mar 11, 2018 at 10:06:58PM +0100, Salvatore Mesoraca wrote:
>> n_ready will always be less than or equal to MAX_MAILBOXES.
>> So we avoid a VLA[1] and use fixed-length arrays instead.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> ---
>>  drivers/scsi/eata.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/eata.c b/drivers/scsi/eata.c
>> index 6501c33..202cd17 100644
>> --- a/drivers/scsi/eata.c
>> +++ b/drivers/scsi/eata.c
>> @@ -2096,7 +2096,7 @@ static int reorder(struct hostdata *ha, unsigned long cursec,
>>       unsigned int k, n;
>>       unsigned int rev = 0, s = 1, r = 1;
>>       unsigned int input_only = 1, overlap = 0;
>> -     unsigned long sl[n_ready], pl[n_ready], ll[n_ready];
>> +     unsigned long sl[MAX_MAILBOXES], pl[MAX_MAILBOXES], ll[MAX_MAILBOXES];
>
> I think we are going to see a recurring theme here.  MAX_MAILBOXES==64
> so this patch adds 1536 bytes to the stack on a 64 bit machine or 768
> bytes on a 32 bit machine.  Linus already commented on another VLA
> removal patch that 768 was a lot of stack space.  That comment did,
> however say 'deep in some transfer call chain'.  I don't know what a
> 'transfer call chain' (the transfer bit) is but is there some heuristic
> we can use to know how deep is deep?  Or more to the point, is there some
> heuristic we can use to know what is an acceptable amount of stack space
> to use?
>
> As far as this patch is concerned wouldn't a kmalloc (with GFP_ATOMIC)
> be ok?  We are in an interrupt handler, can we assume that since IO has
> just occurred that the IO will be so slow comparatively that a memory
> allocation will be quick.  (assuming IO since eata.c only requests a
> single irq line.)

Yes, I think you are right. I'll change it in v2.
Thank you very much,

Salvatore
