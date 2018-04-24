Return-Path: <sergei.shtylyov@cogentembedded.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524558430; cv=none;
        d=google.com; s=arc-20160816;
        b=m0S5gaKvXNZPwBzBqDFHFrRH0+GyvGELRs2xbnztmXcBUWCWJlHnmtYEGEXQcUFOjn
         zgzpLDUCAhixDPF0uH4aivEq6yBs/oWf0vUPQZhXk71mSogtRuXrdiBSSPhXfmvuTzOv
         x8WGkthly2/YmlX8wE3Zr3pRQzPrdYU4u3LBzVmQoHp5uzgA4bg9apHuQHph57ah5nvr
         QtrMHim+GYBK/yFGxwYQRdImMAkMG4Q+ZX0tGx0eWx47J+5eqSOVEqOrt/MhAtEcVBvK
         2M9Jk4LBzDXNRpg2Kpvzpalk97dEHyMc4xV1EdsZe3z+U+8np4SKvw/ThUJE+Ya8DBuq
         8UfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Q+6RSk4ep7QLRcZa90Zp6UPWz59pUmCZ3GTnZbeDbnQ=;
        b=Deuq5Lss+/KOOKSTxKGgdbqp+wcjicA+wi2XOKW5eBSiMlg4rnqjoUQBDm23ldlwrQ
         XXlFb4aG0LkQinKZTAkwvW7aSgaxi68drNl+Sak0xXB2D9xvXzRvklVRwGPZuk8JNmhs
         VrW1Bo/MrSpNjPo+MVETplgvC83PMUcrYhfIDFJdnRP+2WQsYqRdvT9mZqCv/sVcLici
         uZ9i7PZUhP+q6mnxrTU9PHC7BYWU75eUCQ0pV2kMdvFb1ApWWNJwcIsbah20yLLcN0Hk
         vf1NDbLMiaEMVqciM9bKoDlmi7PXw4vRUEUvEVZpOLlxuHOCqkWgmOFvP/KFe5CVvywQ
         o8ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=LqOhm9+t;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=LqOhm9+t;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
X-Google-Smtp-Source: AIpwx4+wJknb9aIUGUucjRilowZAWhssmS1dCYywBGJ0FbN20v2FhZR3uNH7jYUIIR5C+RilvhybAQ==
Subject: Re: [PATCH 2/2] usb: dwc2: fix isoc split in transfer with no data
To: William Wu <william.wu@rock-chips.com>, hminas@synopsys.com,
 felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
 huangtao@rock-chips.com, dianders@google.com, daniel.meng@rock-chips.com,
 John.Youn@synopsys.com, wzz@rock-chips.com, zsq@rock-chips.com,
 Allen.Hsu@quantatw.com, StanTsui@AOPEN.com
References: <1524537824-22010-1-git-send-email-william.wu@rock-chips.com>
 <1524537824-22010-3-git-send-email-william.wu@rock-chips.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <799e2eea-be83-b3c1-3ee7-7a66b1759379@cogentembedded.com>
Date: Tue, 24 Apr 2018 11:27:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524537824-22010-3-git-send-email-william.wu@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598593891532629314?=
X-GMAIL-MSGID: =?utf-8?q?1598615381004901943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 4/24/2018 5:43 AM, William Wu wrote:

> If isoc split in transfer with no data (the length of DATA0
> packet is 0), we can't simply return immediately. Because the
> DATA0 can be the first transaction or the second transaction for
> the isoc split in transaction. If the DATA0 packet with on data
                                                           ^^ no?

> is in the first transaction, we can return immediately. But if
> the the DATA0 packet with on data is in the second transaction

   One "the" too many. And that "on data" again... :-)

> of isoc split in transaction sequence, we need to increase the
> qtd->isoc_frame_index and giveback urb to device driver if needed,
> otherwise, the MDATA packet will be lost.
> 
> A typical test case is that connect the dwc2 controller with an
> usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
> headset) into the downstream port of Hub. Then use the usb mic
> to record, we can find noise when playback.
> 
> In the case, the isoc split in transaction sequence like this:
> 
> - SSPLIT IN transaction
> - CSPLIT IN transaction
>    - MDATA packet (176 bytes)
> - CSPLIT IN transaction
>    - DATA0 packet (0 byte)
> 
> This patch use both the length of DATA0 and qtd->isoc_split_offset
> to check if the DATA0 is in the second transaction.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
[...]

MBR, Sergei
