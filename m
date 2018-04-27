Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZoGV+928DhCa2O6je26wLbOmhLlB4eyirqckYxgTLGtMAJu9AflwbOv7i9Hd2nF7gfy8Pmq
ARC-Seal: i=1; a=rsa-sha256; t=1524826727; cv=none;
        d=google.com; s=arc-20160816;
        b=mQ1yAQekmc1AO1uq9nB4JxLQbZEAr71zsEjQRYSDklHF1aXrjaJLUSc+nr4bwdAcp8
         1gRQf6BQJzSMA2icH0o84itY/lGQxX4UXQ8dqShIKKWGl4s64jv4Gudlw79o2UY+mv9q
         G6XTI8z6y7Wkxe28aMSvtZZJnuFs5gTTrrgqMgSVgeXlCCCxaUljo8HvwgGxNjBbczdX
         meuv8GvcypwKn3lAgAqR/rp5d0RyhYAcyIbD+bjBCRtHXNaSa3HA/FExkoNbu7pbx/kd
         e5xnFz+pWStGqhqSumpWwnS12G2dwl1dMB5sQ+P3LFUr4wPPcps/7cReZ2V5e5s5Dzj5
         wH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=e9S5d1Q3oTnpjl0DP48TnBwXrvq3yVLNfqX5i324G0Y=;
        b=tUvZAkZSN7uN+BXlPcmC7Oj6LEh7UM3bi9G1GiCnJ3bit70WHS/xnXA45C+cEHRjgf
         G0qnzUJpStGRRnARLjPE1S/e0L2r0lH9MWqNloK4rgxBa9BSknNp544om6FDyytnoz8r
         LfB5/Jr357v+htW89ogOHSqc7zHof2x4Oq+3V7J+Jv0px/FdVSICWWJszgYuVVqoqvTE
         NmTHoi+u/q/bZvsq7+Li2w2afDz3jSYJ26mNbFwbQNw/FgU8Tb3QARvdzelY+k8mAo1z
         LYr8oRQ+THPjuOprhX/HqNiv+jplDJU/SjdV3///NveVGxJ7OzENjyJuF+LFs3fqeT+X
         t9hA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Fri, 27 Apr 2018 12:58:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: KY Srinivasan <kys@microsoft.com>
cc: "x86@kernel.org" <x86@kernel.org>,
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
    "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
    "jasowang@redhat.com" <jasowang@redhat.com>,
    "hpa@zytor.com" <hpa@zytor.com>,
    Stephen Hemminger <sthemmin@microsoft.com>,
    "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
    "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the
 hypercall input page
In-Reply-To: <MW2PR2101MB1113D86F6625FE95B5F25A67A08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1804271257230.2076@nanos.tec.linutronix.de>
References: <20180425181110.8683-1-kys@linuxonhyperv.com> <20180425181250.8740-1-kys@linuxonhyperv.com> <20180425181250.8740-5-kys@linuxonhyperv.com> <alpine.DEB.2.21.1804270022340.1596@nanos.tec.linutronix.de>
 <MW2PR2101MB1113D86F6625FE95B5F25A67A08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742891262366400?=
X-GMAIL-MSGID: =?utf-8?q?1598896711131522162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018, KY Srinivasan wrote:

> 
> 
> > -----Original Message-----
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Sent: Thursday, April 26, 2018 3:24 PM
> > To: KY Srinivasan <kys@microsoft.com>
> > Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> > kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> > apw@canonical.com; jasowang@redhat.com; hpa@zytor.com; Stephen
> > Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> > <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> > Subject: Re: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the
> > hypercall input page
> > 
> > On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:
> > 
> > > From: "K. Y. Srinivasan" <kys@microsoft.com>
> > >
> > > Consolidate the allocation of the hypercall input page.
> > 
> > Again. You can provide the new way of allocation first, then you don't have
> > to add code first in order to remove it later again. 
> 
> I have implemented the new way upfront for the new code - the IPI code
> [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments.
> What I am doing here using that infrastructure for the TLB flush enlightenments
> and getting rid of unnecessary code.

Ok. I maybe misread it, but a bit more elaborate change log might help to
avoid that.

Thanks,

	tglx
