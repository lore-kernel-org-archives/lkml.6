Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518507901; cv=none;
        d=google.com; s=arc-20160816;
        b=cAAsKnQ3Hj5rsS9clAdgYKwUFJosTVGbRv0OPyij8DgwosLV0QHtOTU1uvfygl6UPs
         /q0HzoEDfDAcCkedHzX9PCQreraYY+Ez7ee4rEby67+9yr4olkxhIMskH1hlX0+zeJZN
         R1qZ2mvh8OjYForb/Oh5EzfVOfqa/lmfq8OOKAkyrM7UV7xrvgVkJVvAgboEgLM/cwGB
         2U2AC9ae7vSY/UFpLcKNWONG4VXD3XeNkFhxaLGru8TqE8TNnneQ6sIYWIQiDVz0c7em
         ePwHjGtOqsDiCMFpx56xSWKPGD5uxm1KczsEVzbPLzJa7UkQuLBWdz+e77MJUSJRdDi0
         WiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=V/E/6sa7xHuVnBUWHmdPakaMz6/8XRAwZ2yPyqE5G8w=;
        b=WTLBJRSS5UHDXNwZi8MCKxt0o0X8uKsHG8Mo9RtFzxq+dsA5MIi1e8yJ8H6FpBVDsT
         YiNRBFdJ8QHxT3BZKox2wIXJf9MHE6o24rOK6nXfUdRWhnfXyyIVxM2FD1zGpvlvMOQU
         bhwnWUCsTThJm1akjliqdJy3P7HHHn8evIZ+psTRziVuWT4tBX6ZJW0ZXzaEeewNxyzz
         XUW1wM/niGnJzYmqQaI0nG8qoUu6R8+s+f621wexGK8L6DvTJCfyXmUL2aCzmeKOmTst
         wuc9yMbu9SDjHiBcHIwccDZHzCCG+4kc/M/zB5jIibaXewwZVSI7NVHbtO+69Ncd4kcg
         wY6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=m+/AvhWB;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=m+/AvhWB;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225WqjAHGs929v35cWJiYdnpGtMoZnYA83OiV18/EtDh4+QXqHKPgCLSDVvq9kcLPeMTIhwtsQ==
MIME-Version: 1.0
In-Reply-To: <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org> <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Feb 2018 16:44:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BmroRf-C8dQkvTKHWK1psGnNi1t7g-q=Xce6KjrGTsdw@mail.gmail.com>
Message-ID: <CAAFQd5BmroRf-C8dQkvTKHWK1psGnNi1t7g-q=Xce6KjrGTsdw@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] base: power: runtime: Export pm_runtime_get/put_suppliers
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>, freedreno@lists.freedesktop.org,
	David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737849838824813?=
X-GMAIL-MSGID: =?utf-8?q?1592270940828000329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vivek,

On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> The device link allows the pm framework to tie the supplier and
> consumer. So, whenever the consumer is powered-on the supplier
> is powered-on first.
>
> There are however cases in which the consumer wants to power-on
> the supplier, but not itself.
> E.g., A Graphics or multimedia driver wants to power-on the SMMU
> to unmap a buffer and finish the TLB operations without powering
> on itself.

This sounds strange to me. If the SMMU is powered down, wouldn't the
TLB lose its contents as well (and so no flushing needed)?

Other than that, what kind of hardware operations would be needed
besides just updating the page tables from the CPU?

Best regards,
Tomasz
