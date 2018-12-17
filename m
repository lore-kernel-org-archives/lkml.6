Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A6CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C4C204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeLQLjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:39:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43738 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:39:31 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 52bff81ab349af87; Mon, 17 Dec 2018 12:39:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][RESEND] drivers: base: remove need for a temporary string for the node name
Date:   Mon, 17 Dec 2018 12:39:03 +0100
Message-ID: <2449257.d8gDasH2Fh@aspire.rjw.lan>
In-Reply-To: <20181206170557.27834-1-colin.king@canonical.com>
References: <20181206170557.27834-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 6, 2018 6:05:57 PM CET Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the node name is being formatting into a temporary string
> node_name, however, kobject_init_and_add allows one to format up
> a node name, so use that instead. This removes the need for the
> node_name string and also cleans up the following warning:
> 
> Fixes clang warning:
> warning: format string is not a string literal (potentially
> insecure) [-Wformat-security]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/swnode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 9c63ec8d8ab4..306bb93287af 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -553,7 +553,6 @@ fwnode_create_software_node(const struct property_entry *properties,
>  {
>  	struct software_node *p = NULL;
>  	struct software_node *swnode;
> -	char node_name[20];
>  	int ret;
>  
>  	if (parent) {
> @@ -576,8 +575,6 @@ fwnode_create_software_node(const struct property_entry *properties,
>  	}
>  
>  	swnode->id = ret;
> -	sprintf(node_name, "node%d", swnode->id);
> -
>  	swnode->kobj.kset = swnode_kset;
>  	swnode->fwnode.ops = &software_node_ops;
>  
> @@ -590,7 +587,7 @@ fwnode_create_software_node(const struct property_entry *properties,
>  		list_add_tail(&swnode->entry, &p->children);
>  
>  	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> -				   p ? &p->kobj : NULL, node_name);
> +				   p ? &p->kobj : NULL, "node%d", swnode->id);
>  	if (ret) {
>  		kobject_put(&swnode->kobj);
>  		return ERR_PTR(ret);
> 

Applied, thanks!


