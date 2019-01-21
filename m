Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE17C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B0120879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078612;
	bh=mnwKMLIhAkidMjnIn6SwuNM503zATsxKDchncSzlcTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vGrTUTOYjO2G6KeSO2TCKkrsH4nwwmbGrUXVt36BlslpFuJFBpjnptFajK9M98RWt
	 bIrilBNduj05yOqldD0kAXt72a556IY4CjaBd3NIh+jUeHXu1YDg0w+0EfQ1DXYce3
	 zKhkB1npEpHdTRK20M0u9WJJd2T087IkTWZH9pB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfAUNuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfAUNuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5087220879;
        Mon, 21 Jan 2019 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078607;
        bh=mnwKMLIhAkidMjnIn6SwuNM503zATsxKDchncSzlcTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCGNZObIJyg4jbZWAlhVJsJQQG4KrYYuKEnbAzFw4inGKjZK57/eogGAisrdIpqFt
         KHUn9gNpZIKWqd0OXcJmVqnAZULeBxZklWTQtxrcYrOnoMGwU/55hLxaCyoXnlQmT5
         +m9x1OdkMGJ4L1TSXqnbyUChAi00x4SAVxExgBes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.20 054/111] OF: properties: add missing of_node_put
Date:   Mon, 21 Jan 2019 14:42:48 +0100
Message-Id: <20190121122501.854040535@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 28b170e88bc0c7509e6724717c15cb4b5686026e upstream.

Add an of_node_put when the result of of_graph_get_remote_port_parent is
not available.

The semantic match that finds this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@r exists@
local idexpression e;
expression x;
@@
e = of_graph_get_remote_port_parent(...);
... when != x = e
    when != true e == NULL
    when != of_node_put(e)
    when != of_fwnode_handle(e)
(
return e;
|
*return ...;
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/property.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -806,6 +806,7 @@ struct device_node *of_graph_get_remote_
 
 	if (!of_device_is_available(remote)) {
 		pr_debug("not available for remote node\n");
+		of_node_put(remote);
 		return NULL;
 	}
 


