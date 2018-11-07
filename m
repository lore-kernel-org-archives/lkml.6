Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21689C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73F120817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73F120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeKGWDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:03:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:16582 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbeKGWDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:03:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 04:33:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="106039638"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2018 04:33:36 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 07 Nov 2018 14:33:35 +0200
Date:   Wed, 7 Nov 2018 14:33:35 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4/6] drivers: base: Introducing software nodes to the
 firmware node framework
Message-ID: <20181107123335.GF13048@kuha.fi.intel.com>
References: <20181105145928.46819-5-heikki.krogerus@linux.intel.com>
 <20181107043933.wqszrfajrfy6hv7u@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107043933.wqszrfajrfy6hv7u@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 07:39:33AM +0300, Dan Carpenter wrote:
> Hi Heikki,
> 
> url:    https://github.com/0day-ci/linux/commits/Heikki-Krogerus/device-property-Introducing-software-nodes/20181106-031310
> 
> smatch warnings:
> drivers/base/swnode.c:391 fwnode_create_software_node() error: dereferencing freed memory 'swnode'
> 
> # https://github.com/0day-ci/linux/commit/a8c9678ea46a0171baed68e4ec355a9b3f967458
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout a8c9678ea46a0171baed68e4ec355a9b3f967458
> vim +/swnode +391 drivers/base/swnode.c
> 
> a8c9678e Heikki Krogerus 2018-11-05  365  
> a8c9678e Heikki Krogerus 2018-11-05  366  struct fwnode_handle *
> a8c9678e Heikki Krogerus 2018-11-05  367  fwnode_create_software_node(const struct property_entry *properties,
> a8c9678e Heikki Krogerus 2018-11-05  368  			    const struct fwnode_handle *parent)
> a8c9678e Heikki Krogerus 2018-11-05  369  {
> a8c9678e Heikki Krogerus 2018-11-05  370  	struct software_node *p = NULL;
> a8c9678e Heikki Krogerus 2018-11-05  371  	struct software_node *swnode;
> a8c9678e Heikki Krogerus 2018-11-05  372  	char node_name[20];
> a8c9678e Heikki Krogerus 2018-11-05  373  	int ret;
> a8c9678e Heikki Krogerus 2018-11-05  374  
> a8c9678e Heikki Krogerus 2018-11-05  375  	if (parent) {
> a8c9678e Heikki Krogerus 2018-11-05  376  		if (IS_ERR(parent))
> a8c9678e Heikki Krogerus 2018-11-05  377  			return ERR_CAST(parent);
> a8c9678e Heikki Krogerus 2018-11-05  378  		if (!is_software_node(parent))
> a8c9678e Heikki Krogerus 2018-11-05  379  			return ERR_PTR(-EINVAL);
> a8c9678e Heikki Krogerus 2018-11-05  380  		p = to_software_node(parent);
> a8c9678e Heikki Krogerus 2018-11-05  381  	}
> a8c9678e Heikki Krogerus 2018-11-05  382  
> a8c9678e Heikki Krogerus 2018-11-05  383  	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
> a8c9678e Heikki Krogerus 2018-11-05  384  	if (!swnode)
> a8c9678e Heikki Krogerus 2018-11-05  385  		return ERR_PTR(-ENOMEM);
> a8c9678e Heikki Krogerus 2018-11-05  386  
> a8c9678e Heikki Krogerus 2018-11-05  387  	swnode->id = ida_simple_get(p ? &p->child_ids : &swnode_root_ids, 0, 0,
> a8c9678e Heikki Krogerus 2018-11-05  388  				    GFP_KERNEL);
> a8c9678e Heikki Krogerus 2018-11-05  389  	if (swnode->id < 0) {
> a8c9678e Heikki Krogerus 2018-11-05  390  		kfree(swnode);
>                                                               ^^^^^^
> a8c9678e Heikki Krogerus 2018-11-05 @391  		return ERR_PTR(swnode->id);
>                                                                        ^^^^^^^^^^
> a8c9678e Heikki Krogerus 2018-11-05  392  	}

Thanks!

-- 
heikki
