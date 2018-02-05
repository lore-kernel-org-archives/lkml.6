Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbeBEMLN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:11:13 -0500
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:57140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752962AbeBEMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:10:57 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2196:2199:2393:2559:2562:2693:2828:2898:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3873:4321:4385:4605:5007:6742:8660:9149:10004:10400:10848:11026:11232:11658:11914:12043:12438:12663:12740:12760:12895:13069:13148:13230:13255:13311:13357:13439:14659:14721:21080:21611:21627:30054:30060:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: goat97_5eda318a6783b
X-Filterd-Recvd-Size: 2790
Message-ID: <1517832650.7489.256.camel@perches.com>
Subject: Re: [PATCH v12 7/9] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
From: Joe Perches <joe@perches.com>
To: John Garry <john.garry@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, Hanjun Guo <hanjun.guo@linaro.org>,
        "dann.frazier@canonical.com" <dann.frazier@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Linux PCI <linux-pci@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 05 Feb 2018 04:10:50 -0800
In-Reply-To: <8beedbb3-9098-6440-9ddf-e64b2a8e5151@huawei.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
         <1516725385-24535-8-git-send-email-john.garry@huawei.com>
         <CAJZ5v0ghc1sthrMBobSXfNrxoKrjbie9qnKYnLdxnpLfZPzs8w@mail.gmail.com>
         <8beedbb3-9098-6440-9ddf-e64b2a8e5151@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-05 at 11:01 +0000, John Garry wrote:
> On 04/02/2018 07:45, Rafael J. Wysocki wrote:
> > +       /* translate the I/O resources */
> > > +       for (i = 0; i < count; i++) {
> > > +               if (resources[i].flags & IORESOURCE_IO) {
> > > +                       ret = acpi_translate_logicio_res(adev, host,
> > > +                                                       &resources[i]);
> > 
> > You don't need to break this line as far as I'm concerned.
> 
> This is just to keep checkpatch happy. I could move the complete 
> function call to a single line. And also shortening some symbols will help.

This could also use continue as well

	/* translate the I/O resources */
	for (i = 0; i < count; i++) {
		if (!(resources[i].flags & IORESOURCE_IO))
			continue;
		ret = acpi_translate_logicio_res(adev, host, &resources[i]);
		if (ret) {
			kfree(resources);
			dev_err(child, "Translate I/O range failed (%d)!\n",
				ret);
			return ret;
		}
	}
