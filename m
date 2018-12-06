Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69069C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2593C2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544081292;
	bh=7Ew0s3AS4S2VTMpcVQfALiLE8Lr3syQpyPwC9vsuXeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fbVTdbmVmpuUhuXMJA6Rj77n3bpYgnQ30uBIlxq8PrTpdbgc77t9OamCYS9e+hZS7
	 uNAU3fmcJWG+ALNpRCI5R6MMSx+jVqbRuIes8Y4Em/dxGxZaDdy0Lwi93qGZNJ9NX3
	 lLMRaFnpklBBqKFgQncQWTjHHJqMiIslAuGGL45k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2593C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeLFH2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:28:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbeLFH2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:28:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216C020989;
        Thu,  6 Dec 2018 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544081290;
        bh=7Ew0s3AS4S2VTMpcVQfALiLE8Lr3syQpyPwC9vsuXeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wDsNU7jKWLO51foY5kd6fZw45+30NQ0PhL+GZNcSnVNGP/dEerFt+VRcjLuBllYBg
         yGZDHAtfAjHyw5Y9Hg/Mq4Zm40ro7D9LOd4Y02VDnjjepuVPSHB8HFAzVQXHO2muc3
         3J1fknUUyonDx7txZD+37QUTFB3bIY3FEKe3T/0I=
Date:   Thu, 6 Dec 2018 08:28:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 4.19 044/110] drm/i915: Disable LP3 watermarks on all SNB
 machines
Message-ID: <20181206072807.GA21314@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135923.048859299@linuxfoundation.org>
 <20181205213905.GW9144@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205213905.GW9144@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:39:05PM +0200, Ville Syrjälä wrote:
> On Thu, Nov 29, 2018 at 03:12:15PM +0100, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> This one apparently introduces some annoying dmesg errors:
> [    3.487895] [drm:intel_print_wm_latency [i915]] *ERROR* Primary WM3 latency not provided
> [    3.487926] [drm:intel_print_wm_latency [i915]] *ERROR* Sprite WM3 latency not provided
> [    3.487955] [drm:intel_print_wm_latency [i915]] *ERROR* Cursor WM3 latency not provided
> 
> To silence those please also backport
> commit 274dba1ae8ff ("drm/i915: Downgrade Gen9 Plane WM latency error")

That commit id is not in Linus's tree, are you sure it is correct?

thanks,

greg k-h
