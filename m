Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD33C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F6B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079220;
	bh=KQ4KRdPaVkNAaD3UWtpk/QIAehfmVm/Np5ngm5kWoG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NScBPA1vKUqfUYQt+N3JF6ZDHblt8sRt/Vw/m6f4WvbbfVJPacEBNREF5l7HMFOlh
	 7HeRyshGSVWrFGDJvbngNoGLmBppXCvInoQQxKlnqgTYK2/H1eNA5uxeDDD7bawVka
	 9f4IZzXX3RQCs4OpXYF4Jx56pDdRQiPkjKDxWeX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfAUOAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731853AbfAUOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93915217D6;
        Mon, 21 Jan 2019 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079217;
        bh=KQ4KRdPaVkNAaD3UWtpk/QIAehfmVm/Np5ngm5kWoG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TinksnoI2oGkKBFI64Ch8F2V8+4JqMh6WTPkqwQ6RWCivxHlgeelxgaQGJ3vxf0F6
         95TnMvvYrP8JjMg6Ih6SScMUc/pAaGVgBa9X44cuYoCIcRJLIWQ0kgsn+bcrQjRXPL
         NnjgrLCIGf+fwWtu8hZ+GqY0oidIIhvuiKVkuthE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.19 49/99] OF: properties: add missing of_node_put
Date:   Mon, 21 Jan 2019 14:48:41 +0100
Message-Id: <20190121134915.837141860@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 


