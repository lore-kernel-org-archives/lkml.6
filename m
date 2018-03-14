Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521056414; cv=none;
        d=google.com; s=arc-20160816;
        b=nlrP7oc9jPPQHFseHIrjvfNZ1eWCJOwhKYL1pQBI5OcYn2Zr6bU4tZZ+55FyB2cBLs
         n3LWSmWIxIAPzc8JdaPYdNau3S3SutN1ATkWmRj9HMcYyd7QMMxLfnTmyYuPU+5Ew0AZ
         SpUcktl36GazA8wWZYtsPkAm7PMVLV6ZNQ3+TXQ0tW08Vv/HrIgJ8BEktzhbjvEU49Le
         KfamA1c+H4RGtCfSMQnLdqkVUgR9mBtGlDzT30BHrULWY7w/ytKbnJKZlKph0CeD2fZa
         QLLztrGyMoLW1AWbnNetu55+dvbykHYclD7xMndSiavhphfChafTKZQUpA5/Fnt4Wdc3
         hr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=tAnDt9gNM7DivoW6DOeu4kUKccdGXXA1Kk3L46UmOjA=;
        b=JAYWtRv3hpVodJb15/RBnVfzx2Cy439NtX1wKgNslCNFgAWyew3WXX2jhzGq1fmQnw
         7Hb53DuHhWXJoyBeMLW7Fk9Fo7Z8J9PZXTE8ZuglOUWdxmrBZPGOeQ5KKbenDdTlzY2F
         IP/0JTMYJTuPQ5ttx7rWDTzhQW9n541I8K1oaAtFaN1c6i4VfIZR5zoY7PJ0za/6OlM+
         syqwavEaT9CqkUI4/oF9BJJs9l+/AVcHH3YA61iynEnsj6cWjULaMBfIP2NDwulLVn6d
         NNieL1fVHQoz023hlGhNdujWAvQsqFLyjgHJ14wyIEE9h5GZrBYKlZwr9V5LzyCSMK2+
         IEjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oyySNl60;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oyySNl60;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs7b/YanQwUT0Xg5qy+FC/WS2suN0jd2cgppPx+Vl4kVPqA4Kxj0aHeBerlwe/SemJJe0a7ig==
Subject: Re: [PATCH 0/4] ARM: brcmstb: Add support for the V7 memory map
To: Florian Fainelli <f.fainelli@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Cc: Brian Norris <computersforpeace@gmail.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20180223210923.544-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d1c70d19-2d37-1fcd-5945-721557ab6962@gmail.com>
Date: Wed, 14 Mar 2018 12:40:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227538446054373?=
X-GMAIL-MSGID: =?utf-8?q?1594943251043385750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 01:09 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series updates the brcmstb.S DEBUG_LL routines to dynamically detect
> one of the latest STB chip: BCM7278. This chip has a different memory map which
> requires use to lookup the main ID register to know whether which register
> physical offset we must use.
> 
> As a consequence of doing that, we do a number of things:
> 
> - allow the inclusion of cputype.h in assembly files to reduce the duplication
>   of constants
> - define the Brahma-B53 and Brahma-B15 main ID register values, which was long
>   overdue
> - finaly update brcmstb.S to detect 7278 and offset the base register address
>   accordingly
> 
> Note that Doug had a slightly different approach in our downstream tree where he
> actually added the same MIDR_* constants similar to what ARM64 has, I took that
> part away in order to minimize the delta, but I can easily submit that patch
> if this is the desired direction moving forward.

Russell, I would be more comfortable taking those changes through our
Broadcom ARM SoC pull requests, since the majority of the changes are in
brcmstb.S, can I get your acknowledgment for the first 3 patches?

Thank you!

> 
> Thank you!
> 
> Doug Berger (3):
>   ARM: Allow this header to be included by assembly files
>   ARM: add Broadcom Brahma-B53 main ID definition
>   ARM: brcmstb: Add support for the V7 memory map
> 
> Florian Fainelli (1):
>   ARM: add Broadcom Brahma-B15 main ID definition
> 
>  arch/arm/include/asm/cputype.h   | 15 ++++++++++++---
>  arch/arm/include/debug/brcmstb.S | 21 ++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 


-- 
Florian
