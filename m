Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520809847; cv=none;
        d=google.com; s=arc-20160816;
        b=clrH8IXD20eE57MJ1KaoP5zhBW1x94ljUXXgUJPdrOSwvbcBM9iS4Lj7DqHJchaQOD
         F3+a0sDdB78sNvIhRAZiuhdayCkZAth/gn1bwDf3xbGvMJL3kL/r9yMo5RAExGsITIhg
         3TdyKlyvkrVY5/nq2Pa/Zu29JEDonujqCycRjP2+gxyMhxP5426OUdROaRUgTzFdv6ee
         3CoSjnaxA8ySCUq2ULKEkk2XxAh8s2K/RuDNEFR3vsMdC1lcvzMigie4PoVxpso93ozj
         RxY0gjh+HC+5H2gxrisp6O1reDDwY4RH3KCD7xed43tNuBsl3gW3lZB0zvg2YC61GNJj
         JqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=0vEeaUebrD6heg1gFA7HXnvI/bOzBEajc3Nhohcsp4w=;
        b=bMnkootYGZkq6cwcreUrsOIT4d+Qt1cwCmxCVp2jIFIFP582yuTQcyFFDG47jR70qG
         n7cJrTk13F1GVvrXQyj0LxEEaLarlVbJaeeLDxZOtHotw0n/4JCEcg/Rg9BbeaU2/uTX
         ejRGWTJRma5ndgtJ96HpL2olCqAjt+4O4ZFgCAe+Oclw5/WDyHmEGlJj4GF1ACuR9iOq
         DHGoHoc3yM2wrtjYOetHL2crDsBs3IzCKhjrEhvcgo5lrRRi53WcxGvMnqSUvqNY4NBl
         BuL7r2W+jOkTI5mrnArq7QxrAqhUOyk5xpT+uHn471A45qlm0mA058f8ouWaBkVb5mCg
         kzmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=g+HCQV6W;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=g+HCQV6W;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELtB3gKv2q//Ce7x8+t3WI3lmV3vYLjFh2BwOD1vkXh9OxB27FP+VQOdHrxY/4NgdGQp0/+1cA==
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: Andres Rodriguez <andresx7@gmail.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
 <bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Ilia Mirkin <imirkin@alum.mit.edu>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA5B777.5020106@broadcom.com>
Date: Mon, 12 Mar 2018 00:10:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594684706927032915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/11/2018 5:05 PM, Andres Rodriguez wrote:
>> Your patch series then should also have the driver callers who you
>> want to modify to use this new API. Collect from the 802.11 folks the
>> other drivers which I think they wanted changed as well.
>
> Arend, Kalle, would love to hear your feedback.

I am not sure if it was ath10k, but Kalle will surely know. The other 
driver firing a whole batch of firmware requests is iwlwifi. These 
basically try to get latest firmware version and if not there try an 
older one.

The brcmfmac driver I maintain is slightly different. It downloads two 
distinct pieces of firmware of which one is optional for certain 
configurations. Currently, my driver does two asynchronous requests for 
it, but I consider changing it and only make the first request 
asynchronous and the second request synchronous. You can look at the 
current code in drivers/net/wireless/broadcom/brcmfmac/firmware.c. 
However, I did quite some restructuring last week. Anyway, I probably 
will end up using the "optional" api where appropriate.

Regards,
Arend
