Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELs2ussNQo65oeEzAOhBZHGPg0H2ua4gMZV5J+b2V6OAfploXe/tzyCNEkOlnbzFd446gN18
ARC-Seal: i=1; a=rsa-sha256; t=1520275921; cv=none;
        d=google.com; s=arc-20160816;
        b=nB5/u7aX5CL9RU+ZF7ae90sGhB+DwsM0RN54Znm9yQcPESBgaYBLto0XURnEAdvU9r
         ZLGPqtiT/uGsyEWXlYSzL+qLW1VFCf1yLFJ+3z9fVuTnr6sVg50lux9SU04L1bGmQQXn
         LhHRzywGsF1GbfFAiSmZsPb2uf0nSiAZ7CtzwTaOWKxJt79dBRotBTEQc2dxRLRk5euS
         CDW9DYel4l5wEdy8Ktd5i0+H0s4kZdCl1f5S3hau5degk4mS/mTxY+jUxqQdykGy5OLE
         j0K2b0jXYm7LDdWuSgfiBvpDGGlAsaU40Sl0QqLMj8UlgVw9bFglyxiKDsum3/xBdWy2
         s2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=I+tu6OGifq495SpZnOg9JJRzBlV7haH+K+dy6juIXAE=;
        b=BcAFkY6ByUySmvgwDH5IMUZIwU2ZmcsOkiQBPWlifxIQC0FY4SlBUjKtsfylFcqceo
         gHgjql/xwoHJnayfTg33u8L753lOKfWTizd+Y148NkqehtK6aae5d/zINnmyZKtgl5eM
         6qk2/I/JdB3oGBNP0LJXElA+FIpCNVBMapJglVNZiROdw9x+rfXBoYVpXHD2pVrldimd
         Z3l+P1SdclNFpOl6XQPChLP9Bh3er9KrMlX64y0lm9AXDwwbZEQEaVmV8gjXkyrdid7x
         sAKF8gJXrjrWKOXPtLqu575h0n8XmXwPTBaArs1f17ZtMhPrxRR+WApVTpeMpk6qFgBH
         2Bmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
To: Christoph Hellwig <hch@lst.de>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
 mark.rutland@arm.com, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
Date: Mon, 5 Mar 2018 18:51:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305183938.GB20086@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594124844981668748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/18 18:39, Christoph Hellwig wrote:
> On Mon, Mar 05, 2018 at 03:48:32PM +0000, Robin Murphy wrote:
>> Unfortunately for us, fsl-mc is conceptually rather like PCI in that it's
>> software-discoverable and the only thing described in DT is the bus "host",
>> thus we need the same sort of thing as for PCI to map from the child
>> devices back to the bus root in order to find the appropriate firmware
>> node. Worse than PCI, though, we wouldn't even have the option of
>> describing child devices statically in firmware at all, since it's actually
>> one of these runtime-configurable "build your own network accelerator"
>> hardware pools where userspace gets to create and destroy "devices" as it
>> likes.
> 
> I really hate the PCI special case just as much.  Maybe we just
> need a dma_configure method on the bus, and move PCI as well as fsl-mc
> to it.

Hmm, on reflection, 100% ack to that idea. It would neatly supersede 
bus->force_dma *and* mean that we don't have to effectively pull pci.h 
into everything, which I've never liked. In hindsight dma_configure() 
does feel like it's grown into this odd choke point where we munge 
everything in just for it to awkwardly unpick things again.

Robin.
