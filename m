Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A3213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C368C20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg36b2MN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368C20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeG3Ptm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbeG3Ptm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:49:42 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE9020870;
        Mon, 30 Jul 2018 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532960070;
        bh=w5Kc8XXkLNCRgUM+w62o6gYcaDSSaDvD/7D3LDS0yRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kg36b2MNwR4T6w0oKB72fimR3YvQWQcuz3JT9PeeM7LgFycFK+6Tko0H8qF6f6nmo
         68emZjxcScVfo7gK8JOYN3GLSpM8Gr3XWbiOWK2cnP1ytcHz29VMp9uYYjWMKfOQ+h
         xHJwRZ3+X/g3DgWyQFwG9aGIJu3ESBajpose2Jjw=
Date:   Mon, 30 Jul 2018 09:14:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com,
        Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pali Rohar <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180730141428.GK173328@bhelgaas-glaptop.roam.corp.google.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
 <5a102163-73bc-c596-8266-186e222e7ceb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a102163-73bc-c596-8266-186e222e7ceb@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 05:16:13PM -0700, Sinan Kaya wrote:
> On 7/27/2018 1:26 PM, Bjorn Helgaas wrote:
> > - A link can lead to a multi-function device, and the spec allows
> >      those functions to have different ASPM settings (see PCIe r4.0,
> >      sec 5.4.1).  With the sysfs files at the upstream end of the link,
> >      we have no way to configure those functions individually.
> 
> Even though we can set them individually, there is only one PCIe link
> for single function as well as multi-function devices.
> 
> It would be a user mistake to allow individual PCIe functions with
> different ASPM policies. (maybe, we should enforce it if we are not
> doing it already).

It's true that multi-function devices share a single PCIe link.

However, the end of sec 5.4.1 does make it clear that the functions
need not have the same ASPM configuration, and it gives rules for how
those different settings should affect the shared link.  Since it
mentions different ASPM Control fields for the different functions, I
assume the policy combining those per-function settings into the
single link behavior must be implemented in the hardware.

Obviously we don't support per-function ASPM settings today.  I don't
know whether there's any value in supporting them or not, but putting
the control files at the upstream end basically precludes us from ever
supporting them.

Bjorn
