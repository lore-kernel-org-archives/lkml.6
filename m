Return-Path: <mattst88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525834694; cv=none;
        d=google.com; s=arc-20160816;
        b=FtfNTx4H1ZdS/AM+TA1WBDCgLjgZcJ7EZIuVUMVaq4ZetZ0cWeMCS/YB9DyfdQlU/f
         l/efcssCzr3Y28UN63C2uZ2NM4moZjyuFwy5zzdv0U4Sxefulj3Vh5k8djYpq6ko8+bi
         i+G2+qc1awl5/4RHm087rJ2tEH2S5DcQjqnqvATxDc+ntplr8lg8/FGMoMp/MATK9uyB
         uLnBtKS1/QvIi/v7Qpbv3S+fJ61LhSOJGyjp2zTBaHJDhoNO86fQwz3/GtZLWyaL2WNX
         CgkL/GcP9YvGpVGh6MmAlXmceouNT1EB9kmpcjy9JbScKRjJU01t5/AjUpo+/dNzhvFu
         S5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3V6078sTNyE6vRCKAWqQM8IE+8J6mVjwWpraQzprASc=;
        b=OUrSvP2cz0WOtkxNikZL55YcePFQud08NXKIrC87yCoxlslCyn0CEMOIK+rOFdlssv
         FiMjPgRk1sGJU6YIyzz5e9HzCSTJMEWYzLbF08U8+MsfjWL+VNb5xSRP3/L1c9r2y00g
         ewqm8/qssp24kscGpJoSIa1tlxWil0ajbseQUvrdJXnJgES8q/ZRTMsRR8gCireYoTAQ
         sdQ6Fmec05ZSRG5+bHuypmwIFTds2RcD5PHUqQenyiQtXVZ7x4ZQf9gonAZi3+yQeqEp
         7JKhVu9pSy3SYXySeasNoxHfQ2nIJS5kFttVfLJulntSbLVQOX0R/+5Tncx7rBSA3Oh7
         wVAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=etS+ZdS9;
       spf=pass (google.com: domain of mattst88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mattst88@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=etS+ZdS9;
       spf=pass (google.com: domain of mattst88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mattst88@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpXaTGT+T1CTInDOcMKZb+2xu0dhyQEYldHiaJkonYV3TY45K+qw3eW0YAZ61aCyxp1y5MpB4a6JM0U8IAtSKE=
MIME-Version: 1.0
In-Reply-To: <2fd54f7c-ff73-5935-a253-c924f4373cc6@codeaurora.org>
References: <1523917017-28084-1-git-send-email-okaya@codeaurora.org>
 <b9d845ad-62af-d300-53d9-2b62f5da6c44@codeaurora.org> <2fd54f7c-ff73-5935-a253-c924f4373cc6@codeaurora.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 8 May 2018 19:57:53 -0700
Message-ID: <CAEdQ38GY9ZtNqOt1ZSetwZjyKAokY6-qEVy1t+t=_FEqx+-+zQ@mail.gmail.com>
Subject: Re: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering #2
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-alpha <linux-alpha@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597942817277668063?=
X-GMAIL-MSGID: =?utf-8?q?1599953641089474983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 9:20 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Matt,
>
> On 4/17/2018 2:43 PM, Sinan Kaya wrote:
>> On 4/16/2018 6:16 PM, Sinan Kaya wrote:
>>> memory-barriers.txt has been updated with the following requirement.
>>>
>>> "When using writel(), a prior wmb() is not needed to guarantee that the
>>> cache coherent memory writes have completed before writing to the MMIO
>>> region."
>>>
>>> Current writeX() and iowriteX() implementations on alpha are not
>>> satisfying this requirement as the barrier is after the register write.
>>>
>>> Move mb() in writeX() and iowriteX() functions to guarantee that HW
>>> observes memory changes before performing register operations.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  arch/alpha/kernel/io.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> Sorry for catching this late but this also needs to go to 4.17 after
>> review.
>>
>> I missed the writel() implementation on arch/alpha/kernel/io.c file
>> on my first patch.
>>
>
> Can you also queue this for 4.17?
>
> There are already drivers checked into 4.17 that dropped the unnecessary
> barriers.
>
> I really hate to see Alpha broken because of this.

Yes, I will pick it up for 4.17.

Thanks for the patch.
