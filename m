Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49N0pw7fCk5eW+D6ahNOqESMP9u8u6O6a1ojiETFAa4pbOu0XByN564dtU8E3EdaVkGHCFy
ARC-Seal: i=1; a=rsa-sha256; t=1523990589; cv=none;
        d=google.com; s=arc-20160816;
        b=gcMGmftBwkSOOLdmPHRmKqUjfUBsGKc4tVRToJHw2irmua0M4Nn+OcbNr5RAoNINQd
         xLPxgOyAkwS1FyHucQtziPhekEFT8pHi9dUeEokCRFK1MXjBgtmgDO6eNbLXNfflEWPF
         mClRsQvC6HhfpjiVp4zKI+iy4qYmwlExcpaazPkQOY8tWwI34i/t7MucVSM+1tEXFL2+
         p7N+a/hXYLiDcQOgvKCQ6bLFZjDAWqJ5LAp7cXTmP8eQ2ppd8vQQEigWS61/YdGn/dfe
         XZEFJsu00mfR2bM/6uZmsug3kGi8w8Az0Imlzxcr53Letql83lvIdf7i+Uvovk0wOeJD
         9nZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ME19N0tgv35uKDpa4GkeitDtlBmxaevcKZIdOprULJ8=;
        b=to+S/CCaqwq7rZfo6CToWgsyuZ0qGj5+EcWfaZi0cmURFj4BctIHTWdMfISNB+b6Wj
         tkmSM2JJ0yIGPY80MS3uAJQVUkDn9zl5yM3zp0B+7wM1mfR0sDEXM3DZ4giuT7rW5xSX
         fSvB1ayiIHWF3MZip0vSxZn62Q9Nl853GRNfU8CIA4Rsz2PV8X2aYpKlEamRyY82lvpd
         q34jPpX8GM9Qd7EhQJNdOolxjYhKlpAeH61Vr4b0b7vyryN4LHP8H5ttLS/qRIDNqhiR
         yA/xy2QYM1o/sgZAgFrdBtrtjGPVgARtG7ZHObT5hKO3IFMnKpsQ41PgjeeymjFBiGZF
         7vIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XcoytxLz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DuDEL/++;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XcoytxLz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DuDEL/++;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D068760F93
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering #2
To: linux-alpha@vger.kernel.org, arnd@arndb.de, timur@codeaurora.org,
 sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <1523917017-28084-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b9d845ad-62af-d300-53d9-2b62f5da6c44@codeaurora.org>
Date: Tue, 17 Apr 2018 14:43:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523917017-28084-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597942817277668063?=
X-GMAIL-MSGID: =?utf-8?q?1598019956064506494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 6:16 PM, Sinan Kaya wrote:
> memory-barriers.txt has been updated with the following requirement.
> 
> "When using writel(), a prior wmb() is not needed to guarantee that the
> cache coherent memory writes have completed before writing to the MMIO
> region."
> 
> Current writeX() and iowriteX() implementations on alpha are not
> satisfying this requirement as the barrier is after the register write.
> 
> Move mb() in writeX() and iowriteX() functions to guarantee that HW
> observes memory changes before performing register operations.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/alpha/kernel/io.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Sorry for catching this late but this also needs to go to 4.17 after
review.

I missed the writel() implementation on arch/alpha/kernel/io.c file
on my first patch.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
