Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AH8x2256sYJctjDN/JHmLRplKAjrRc4rSvNekPBpPpPDMqQKFS4JHpxFoSCHuR3c4hlPAWUdbbKJ
ARC-Seal: i=1; a=rsa-sha256; t=1518523243; cv=none;
        d=google.com; s=arc-20160816;
        b=bw4Ys7N+fmEuv+5FsjIjp0/RcEznzfA17nK1lVCiw/sljpAa5wM9FmdJQGhZ/BSgxU
         6H2s82890KKCxqbHZ15FOY24yUHgWIk5IOE7nSRStvhYK+fi/Sh0yEtrl+YOD+7NK0KF
         Bg+y/N8giXw+6UsiU680QS7XhvLCvdHByUWqkT2dFWdwA8A++13Z5NttxPA/NNhr3GOe
         wIwIlj8g/ePJgO3mISlohgUeMXPRn3tMu4f2y6HWAc7HlwEkMZ0r2665RCynU0oCR7XP
         gcrbpmIcuuRaM3vtIXURIfNwNTPMsplsBV+Ya+E9FjABPwDW9pQB6Xf7luwLbS443Tj/
         cdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+shyu4J3O5+EYfg8elsLr+pCwQ3CWTxEckDJ4+oL5y8=;
        b=UUBrDVX/Pic0g8QK6+yhaRTttKjcGyYhyzycMYm5ySp91/h40vuogpZ1DULQAUbaoU
         e/5RLJzClAbHVt7RMIlk2AhEwSJDfD/Efa1KVxHOXk7eDIIXQ6OXFJtF2PfftZxE2qBy
         UvqB6Vh/2T7dY3BQB/rYlhxIx4lguZ2d8zSdxegfPcHKtm97I3zl0iT2MBeA61orsbfD
         M02cP12NLktZGG2HLKvWAT76hgUdpBJK9T9nm6ihbAxTjCniv+WH1KfiVFNYM01XwRTi
         jOJrYGzyw668d189p8H3eZ43F0gzHUXtetyFdvCYAoaoONZuYfLG/evaopsfOhXuz6z3
         CPIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v7 1/6] base: power: runtime: Export
 pm_runtime_get/put_suppliers
To: Tomasz Figa <tfiga@chromium.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>,
 Rob Clark <robdclark@gmail.com>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
 linux-arm-msm@vger.kernel.org
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5BmroRf-C8dQkvTKHWK1psGnNi1t7g-q=Xce6KjrGTsdw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <65d707c0-76cc-d59e-ff18-1fdd89306900@arm.com>
Date: Tue, 13 Feb 2018 12:00:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BmroRf-C8dQkvTKHWK1psGnNi1t7g-q=Xce6KjrGTsdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737849838824813?=
X-GMAIL-MSGID: =?utf-8?q?1592287028581938466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/02/18 07:44, Tomasz Figa wrote:
> Hi Vivek,
> 
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> The device link allows the pm framework to tie the supplier and
>> consumer. So, whenever the consumer is powered-on the supplier
>> is powered-on first.
>>
>> There are however cases in which the consumer wants to power-on
>> the supplier, but not itself.
>> E.g., A Graphics or multimedia driver wants to power-on the SMMU
>> to unmap a buffer and finish the TLB operations without powering
>> on itself.
> 
> This sounds strange to me. If the SMMU is powered down, wouldn't the
> TLB lose its contents as well (and so no flushing needed)?

Depends on implementation details - if runtime PM is actually 
implemented via external clock gating (in the absence of fine-grained 
power domains), then "suspended" TLBs might both retain state and not 
receive invalidation requests, which is really the worst case.

> Other than that, what kind of hardware operations would be needed
> besides just updating the page tables from the CPU?

Domain attach/detach also require updating SMMU hardware state (and 
possibly TLB maintenance), but don't logically require the master device 
itself to be active at the time.

Robin.
