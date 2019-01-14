Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B308C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1B420656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS9Kdm5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfANUn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:43:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfANUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:43:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so409492wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPW/TPOsfK8EVwwui1CBCtoZzoIlZFL9ga9+cAosqO4=;
        b=GS9Kdm5SfAWny0c/T3FjpwOTPBEz+28qg+BLN3Tl+bgkk9idmCx6iGcW96BjGG38O4
         wP+siSGII8489GMfekKQccX6cv3BNYCeh8sJbOQbu5LVOI53I/e6nlvU2D1dd+X9BhQG
         aj6dn3ij/uzboHPMQvIsbT86dtLXTyR449Z8VY7k/0XFaUwq/R0pB6nFto+ghWQl8k2U
         fszQeOAea2+gmXHUsM+vFyNWX4ykD86TMkQMF7f59LQ8i9bmp29I/HoGbyNhjwxmqnZU
         b4Kkjx6++cJkvVpjZCEQh78yu4l3zlt3YgMxp4ymNiT5jEigH5gXys0fME5/G/rCH0Oz
         8HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BPW/TPOsfK8EVwwui1CBCtoZzoIlZFL9ga9+cAosqO4=;
        b=HedAUG5sZVyHr6oUDHk11z//S97MXIGxdip7yZ4MG1O8FoecJm5zVJNdsiEpLb/nAp
         gDKWzJOQ1fndGEdFlmAY1Xm7cyRcKj1DZoQniOCGpo+6dgwsh9flGFG95JW7YC9SvgsZ
         j1ivSKMsmVtvaFFSv9KL8BiViJJfQg/fae7UcuqgUTfQHRMKB7Bf552KlTHcmgwCdj8d
         vAXJ62L053CzBafXdutzINGF/n49SBuWmwOZv72m+mTzXyOG/kKDbaUjPcswhG3jywkA
         WHge+42OEmlZgrn3lhGW4vTU5ACrmnhWkUEgCW+e20HV9lmFJ8XfD48rvO2Gikco+7wZ
         5uDg==
X-Gm-Message-State: AJcUukfp44G8sBY/oKTnLR6nUNz49sfr/ezomRkwecGyBjLfT/5amGh8
        SuIgEkwXkne+lG68lyUXg24=
X-Google-Smtp-Source: ALg8bN7EdutVFzIqkS/3yO7sJDaHZdD4AamfbUZVY7GfS/C6GbmeEpidj1E3Rx5BDlJZRrQN7ZQ3Gw==
X-Received: by 2002:adf:8068:: with SMTP id 95mr217196wrk.181.1547498635982;
        Mon, 14 Jan 2019 12:43:55 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id c10sm66049695wrw.49.2019.01.14.12.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:43:54 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id E90F111422AD; Mon, 14 Jan 2019 21:43:53 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:43:51 +0100
Message-Id: <20190114204352.22012-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  drivers/firewire/core-topology.c:69:23: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/firewire/core-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 7db234d3fbdd..82c67e900aad 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -67,6 +67,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
 		switch (port_type) {
 		case SELFID_PORT_CHILD:
 			(*child_port_count)++;
+			/* fall through */
 		case SELFID_PORT_PARENT:
 		case SELFID_PORT_NCONN:
 			(*total_port_count)++;
-- 
2.19.2

