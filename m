Return-Path: <jean-philippe.brucker@arm.com>
X-Google-Smtp-Source: AB8JxZo/t9q5JHIrgFXduak4J1hs4ehgGA4crZdXNDb76qdmB74vJfBwZNe7QA+eRJV5AiaVnjAN
ARC-Seal: i=1; a=rsa-sha256; t=1525085898; cv=none;
        d=google.com; s=arc-20160816;
        b=C/vb4rO9RHuJIgijraR4MenhzXg1v7VqzjqLvTZMu7AgdGJo50hIpmDEOVtbv2UN9w
         /4ntmqY74c9XGjCojpMx0GC1MUZvyDCbQzkDserwDjJ8vYUcVL35WnrtK3icWv98qTxm
         ITgPF1yTHMD02xIv0kOVH0mjG6s2m4NDCy4Ccducgf9rGGtUkhnCDCBofQ32JCUNw186
         B56cI976dOYxLuOQx+h8XWpHxk7hi1hDlUUqW7K/IQ5SaAauou4bF4qA3yOFBPzBmAN9
         M3sgZL7JoeN63x5AaC3jmg0AaxWTui6BmnStgF04FQsMh42NGsPOpJa8j09EHPDGbB6Q
         sWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=5vf6VLCs7OZVAco8yTmHhPHYWCWgXV3woOqYvTdFH+s=;
        b=JaHNDwl6PS5OayPV1wz5lvZVY7U0Drva9k1vbWwt7Nq4D1kyFw7dKWRCjYuKSupkft
         1KXs8+vmEd+dLFnKKpaFalhliv+F+L4P/FMVs1Rdo6U29U/uuGH+5M8UDRQw+9zvw07k
         9rD51B4f73CNOpGLjWkunfVRzjvehQaLjYiDUwTW8Zlj4HSVZz1NWtA243hv7ghYkbeh
         mdh60Mpr1C7CU/KOLO7WK/Afu1fod8czRc3JxUEJbTCv6H0iZFE18msnxJ+hLNKcLzRx
         s2QnaqKedPf2QcwxzUJ4fMFn5paASsLp6eKSMPzsD0MXQevou5ND3TDzHYu+zwg392oG
         DKTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Subject: Re: [PATCH v4 14/22] iommu: handle page response timeout
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-15-git-send-email-jacob.jun.pan@linux.intel.com>
 <20180423153622.GC38106@ostrya.localdomain>
 <20180425083711.222202e7@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e98a1385-9e55-c021-4e89-7d07701f4b84@arm.com>
Date: Mon, 30 Apr 2018 11:58:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425083711.222202e7@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910205943696?=
X-GMAIL-MSGID: =?utf-8?q?1599168471601298922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25/04/18 16:37, Jacob Pan wrote:
>> In the other cases (unsupported PRI or rogue guest) then disabling PRI
>> using a FAILURE status might be the right thing to do. However,
>> assuming the device follows the PCI spec it will stop sending page
>> requests once there are as many PPRs in flight as the allocated
>> credit.
>>
> Agreed, here I am not taking any actions. There may be need to drain
> in-fly requests.

Right, as long as we first ensure that no new fault is generated (by
using a Response Failure). Though in my opinion not taking action might
be the safest option :)

Another thought: currently the comment in iommu.h says
"@IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent faults
from this device if possible. This is "Response Failure" in PCI PRI."

I wonder if we should simply say "Drop all subsequent faults from the
device". Even if the PCI device doesn't properly implement PRI, the
IOMMU driver should set a "PRI disabled" bit in the device data that
prevents it from from reporting new faults and flooding the queue.
Anyway, it's a small detail that could go in a future patch series.

>> If there isn't any possibility of memory leak or abusing resources, I
>> don't think it's our problem that the guest is excessively slow at
>> handling page requests. Setting an upper bound to page request latency
>> might do more harm than good. Ensuring that devices respect the number
>> of allocated in-flight PPRs is more important in my opinion.
>>
> How about we have a really long timeout, e.g. 1 min similar to device
> invalidate response timeout in ATS spec., just for basic safety and
> diagnosis. Optionally, we could have quota in parallel.

I agree that for development a timeout is useful. It might be worth
adding it as an option to the IOMMU module instead of a define. Perhaps
a number of seconds, 10 being the default and 0 disabling the timeout?
Otherwise we would probably end up with a succession of patches
incrementing the timeout by arbitrary values, if people find it
inconvenient.

Thanks,
Jean
