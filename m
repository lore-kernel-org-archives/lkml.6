Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869D2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380CA208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="g8CPKJMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380CA208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wp.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGaCd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:33:56 -0400
Received: from mx4.wp.pl ([212.77.101.12]:49845 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731288AbeGaCdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:33:55 -0400
Received: (wp-smtpd smtp.wp.pl 30881 invoked from network); 31 Jul 2018 02:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1532998575; bh=HULyR8zh26O7dnhXXkSJisPX2ahCca7DEjo5lBrDagQ=;
          h=From:To:Cc:Subject;
          b=g8CPKJMeyEvjge/FqfxA1av+X1jyQxAy1aGDeO5FENyZHN2n+dpfByYLSzJFsgte/
           go2xswqx2D6Pnrq84TUFnEuCPt+pcd3/sesAJ7b9YQZPLQbeCvooPckQFPXoXP2pUE
           rxEH8SFdv08m4nPqgzTp5nrx21gz1KgxFnISMiSg=
Received: from 014.152-60-66-biz-static.surewest.net (HELO cakuba.netronome.com) (kubakici@wp.pl@[66.60.152.14])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <mkubecek@suse.cz>; 31 Jul 2018 02:56:15 +0200
Date:   Mon, 30 Jul 2018 17:56:09 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 09/17] ethtool: implement GET_DRVINFO
 message
Message-ID: <20180730175609.18946cce@cakuba.netronome.com>
In-Reply-To: <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
        <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 0c19424e398cf879b88736e75c457d87
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [IbM0]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 14:53:27 +0200 (CEST), Michal Kubecek wrote:
> +GET_DRVINFO
> +-----------
> +
> +GET_DRVINFO request corresponds to ETHTOOL_GDRVINFO ioctl command and provides
> +basic driver information.
> +
> +Request contents:
> +
> +    ETHA_DRVINFO_DEV		(nested)	device identification
> +
> +Kernel response contents:
> +
> +    ETHA_DRVINFO_DEV		(nested)	device identification
> +    ETHA_DRVINFO_DRIVER		(string)	driver name
> +    ETHA_DRVINFO_VERSION	(string)	driver version
> +    ETHA_DRVINFO_FWVERSION	(string)	firmware version

FWIW I think fwinfo belongs to devlink, and should be split.  Most
modern drivers provide versions of multiple FW components smooshed into
a single string.  Perhaps it's time to allow this facility to carry
multiple key: value entries?

> +    ETHA_DRVINFO_BUSINFO	(string)	device bus address

I wonder if some of this information is also not duplicated with
sysfs.  There should be a link from the netdev to a sysfs device.
Same for driver name.  

I'm probably missing some uses (in embedded world?) and will be
corrected.. :)

> +    ETHA_DRVINFO_EROM_VER	(string)	expansion ROM version
> +    ETHA_DRVINFO_N_PRIV_FLAGS	(u32)		number of private flags
> +    ETHA_DRVINFO_N_STATS	(u32)		number of device stats
> +    ETHA_DRVINFO_TESTINFO_LEN	(u32)		number of test results
> +    ETHA_DRVINFO_EEDUMP_LEN	(u32)		EEPROM dump size
> +    ETHA_DRVINFO_REGDUMP_LEN	(u32)		register dump size
