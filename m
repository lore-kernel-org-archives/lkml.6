Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC1EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3072320C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n6HKD/Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3072320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIZAfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:35:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45490 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeIZAfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:35:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so4118799pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JbXX371XcyRiCxPSWRSuCHmP9QFGA3Pa8K2HEyMazrQ=;
        b=n6HKD/Ebc2RqinV8HhuzA2A5V4mO0/j+jqnAjq3r5OeHJB0U6kwJIKxhsH5MCCTRcn
         WygmNV7Fzn5oSmmEWJ4d2RHyjNWvDjso8yD9K4W61+eWkcPo7AYWzIY+mxhufHAJOAaa
         5dQRZ4qVBAOiBYd1jelliNwkcadBAjFRp3x1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbXX371XcyRiCxPSWRSuCHmP9QFGA3Pa8K2HEyMazrQ=;
        b=pIEw3CBhIP25zMeMxYeU6wUYT/Uhh+GSiOhR3fj4MRZp2PvOIybTMcBYeKFKMpgByQ
         OKXFf8akcr8ofxTVQCV3KncAplBDiLf2Qfn+74IEh/KaBmHOHyU2FFlr+5lwd2ZOjPmQ
         nyuWskH0Egj1iuPOO4POzorVobpT1zZoK11qMKJBJBjgqBxHc0VMuOjNfBRb8BInFS/2
         YiTFkJOo5Tj9r+Yk6VnkmaLqQY7BE4S2iEhLdZt/OvCGPZVY82xV12hz1GsHFRq1zsIf
         D/FJyMtlvhrC7jBMln35/3++1NzpV2UaxcZxr/MaIiOeGu9akSSwifZ/M0vfXMEc39mI
         9Aow==
X-Gm-Message-State: ABuFfoin+nkAfVXOJq0N9eswBWqqwzTR9dJfpeuHVt3Wl3sbFhNs1/mT
        Oxs90/ONOJGrOa0vOCFpOe7aJwxXlMM=
X-Google-Smtp-Source: ACcGV616lOHSn94cKgV/uP1kau+fat4fkVH5pCWg6ZuNU397Uo0WrB1VfkFPr4lQWzVgCT4fACqA9g==
X-Received: by 2002:a63:d645:: with SMTP id d5-v6mr2162444pgj.450.1537899988723;
        Tue, 25 Sep 2018 11:26:28 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id x70-v6sm6883626pfk.85.2018.09.25.11.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:26:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [2/5] doc: rcu: Remove rcu_dynticks from Data-Structures
Date:   Tue, 25 Sep 2018 11:25:58 -0700
Message-Id: <20180925182601.37421-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180925182601.37421-1-joel@joelfernandes.org>
References: <20180925182601.37421-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_dynticks was folded into rcu_data structure. Update the data
structures RCU document accordingly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../BigTreeClassicRCUBHdyntick.svg            | 695 ------------------
 .../Data-Structures/Data-Structures.html      |  92 +--
 2 files changed, 25 insertions(+), 762 deletions(-)
 delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBHdyntick.svg

diff --git a/Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBHdyntick.svg b/Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBHdyntick.svg
deleted file mode 100644
index 21ba7823479d..000000000000
--- a/Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBHdyntick.svg
+++ /dev/null
@@ -1,695 +0,0 @@
-<?xml version="1.0" encoding="UTF-8" standalone="no"?>
-<!-- Creator: fig2dev Version 3.2 Patchlevel 5e -->
-
-<!-- CreationDate: Wed Dec  9 17:20:02 2015 -->
-
-<!-- Magnification: 2.000 -->
-
-<svg
-   xmlns:dc="http://purl.org/dc/elements/1.1/"
-   xmlns:cc="http://creativecommons.org/ns#"
-   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
-   xmlns:svg="http://www.w3.org/2000/svg"
-   xmlns="http://www.w3.org/2000/svg"
-   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
-   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
-   width="5.7in"
-   height="8.6in"
-   viewBox="-44 -44 6838 10288"
-   id="svg2"
-   version="1.1"
-   inkscape:version="0.48.4 r9939"
-   sodipodi:docname="BigTreeClassicRCUBHdyntick.fig">
-  <metadata
-     id="metadata166">
-    <rdf:RDF>
-      <cc:Work
-         rdf:about="">
-        <dc:format>image/svg+xml</dc:format>
-        <dc:type
-           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
-        <dc:title></dc:title>
-      </cc:Work>
-    </rdf:RDF>
-  </metadata>
-  <defs
-     id="defs164">
-    <marker
-       inkscape:stockid="Arrow1Mend"
-       orient="auto"
-       refY="0.0"
-       refX="0.0"
-       id="Arrow1Mend"
-       style="overflow:visible;">
-      <path
-         id="path3924"
-         d="M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
-         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.0pt;"
-         transform="scale(0.4) rotate(180) translate(10,0)" />
-    </marker>
-    <marker
-       inkscape:stockid="Arrow2Lend"
-       orient="auto"
-       refY="0.0"
-       refX="0.0"
-       id="Arrow2Lend"
-       style="overflow:visible;">
-      <path
-         id="path3936"
-         style="fill-rule:evenodd;stroke-width:0.62500000;stroke-linejoin:round;"
-         d="M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884,-4.0017078 C 6.9730900,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 z "
-         transform="scale(1.1) rotate(180) translate(1,0)" />
-    </marker>
-  </defs>
-  <sodipodi:namedview
-     pagecolor="#ffffff"
-     bordercolor="#666666"
-     borderopacity="1"
-     objecttolerance="10"
-     gridtolerance="10"
-     guidetolerance="10"
-     inkscape:pageopacity="0"
-     inkscape:pageshadow="2"
-     inkscape:window-width="845"
-     inkscape:window-height="988"
-     id="namedview162"
-     showgrid="false"
-     inkscape:zoom="1.0452196"
-     inkscape:cx="256.5"
-     inkscape:cy="387.00003"
-     inkscape:window-x="356"
-     inkscape:window-y="61"
-     inkscape:window-maximized="0"
-     inkscape:current-layer="g4" />
-  <g
-     style="stroke-width:.025in; fill:none"
-     id="g4">
-    <!-- Line: box -->
-    <rect
-       x="450"
-       y="0"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect6" />
-    <!-- Line: box -->
-    <rect
-       x="4950"
-       y="4950"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect8" />
-    <!-- Line: box -->
-    <rect
-       x="750"
-       y="600"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect10" />
-    <!-- Line -->
-    <polyline
-       points="5250,8100 5688,5912 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline12" />
-    <!-- Arrowhead on XXXpoint 5250 8100 - 5710 5790-->
-    <polyline
-       points="5714 6068 5704 5822 5598 6044 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline14" />
-    <!-- Line -->
-    <polyline
-       points="4050,9300 4486,7262 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline16" />
-    <!-- Arrowhead on XXXpoint 4050 9300 - 4512 7140-->
-    <polyline
-       points="4514 7418 4506 7172 4396 7394 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline18" />
-    <!-- Line -->
-    <polyline
-       points="1040,9300 1476,7262 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline20" />
-    <!-- Arrowhead on XXXpoint 1040 9300 - 1502 7140-->
-    <polyline
-       points="1504 7418 1496 7172 1386 7394 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline22" />
-    <!-- Line -->
-    <polyline
-       points="2240,8100 2676,6062 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline24" />
-    <!-- Arrowhead on XXXpoint 2240 8100 - 2702 5940-->
-    <polyline
-       points="2704 6218 2696 5972 2586 6194 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline26" />
-    <!-- Line: box -->
-    <rect
-       x="0"
-       y="450"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect28" />
-    <!-- Line: box -->
-    <rect
-       x="300"
-       y="1050"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect30" />
-    <!-- Line -->
-    <polyline
-       points="1350,3450 2350,2590 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline32" />
-    <!-- Arrowhead on XXXpoint 1350 3450 - 2444 2510-->
-    <!-- Line -->
-    <polyline
-       points="4950,3450 3948,2590 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline36" />
-    <!-- Arrowhead on XXXpoint 4950 3450 - 3854 2510-->
-    <!-- Line -->
-    <polyline
-       points="4050,6600 4050,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00455750000000066;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline40" />
-    <!-- Arrowhead on XXXpoint 4050 6600 - 4050 4290-->
-    <!-- Line -->
-    <polyline
-       points="1050,6600 1050,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00455750000000066;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline44" />
-    <!-- Arrowhead on XXXpoint 1050 6600 - 1050 4290-->
-    <!-- Line -->
-    <polyline
-       points="2250,5400 2250,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00455750000000066;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline48" />
-    <!-- Arrowhead on XXXpoint 2250 5400 - 2250 4290-->
-    <!-- Line -->
-    <polyline
-       points="2250,8100 2250,6364 "
-       style="stroke:#00ff00;stroke-width:30;stroke-linejoin:miter;stroke-linecap:butt;marker-end:url(#Arrow1Mend)"
-       id="polyline52" />
-    <!-- Arrowhead on XXXpoint 2250 8100 - 2250 6240-->
-    <!-- Line -->
-    <polyline
-       points="1050,9300 1050,7564 "
-       style="stroke:#00ff00;stroke-width:30;stroke-linejoin:miter;stroke-linecap:butt;marker-end:url(#Arrow1Mend)"
-       id="polyline56" />
-    <!-- Arrowhead on XXXpoint 1050 9300 - 1050 7440-->
-    <!-- Line -->
-    <polyline
-       points="4050,9300 4050,7564 "
-       style="stroke:#00ff00;stroke-width:30;stroke-linejoin:miter;stroke-linecap:butt;marker-end:url(#Arrow1Mend)"
-       id="polyline60" />
-    <!-- Arrowhead on XXXpoint 4050 9300 - 4050 7440-->
-    <!-- Line -->
-    <polyline
-       points="5250,8100 5250,6364 "
-       style="stroke:#00ff00;stroke-width:30;stroke-linejoin:miter;stroke-linecap:butt;marker-end:url(#Arrow1Mend)"
-       id="polyline64" />
-    <!-- Arrowhead on XXXpoint 5250 8100 - 5250 6240-->
-    <!-- Circle -->
-    <circle
-       cx="2850"
-       cy="3900"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle68" />
-    <!-- Circle -->
-    <circle
-       cx="3150"
-       cy="3900"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle70" />
-    <!-- Circle -->
-    <circle
-       cx="3450"
-       cy="3900"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle72" />
-    <!-- Circle -->
-    <circle
-       cx="1350"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle74" />
-    <!-- Circle -->
-    <circle
-       cx="1650"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle76" />
-    <!-- Circle -->
-    <circle
-       cx="1950"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle78" />
-    <!-- Circle -->
-    <circle
-       cx="4350"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle80" />
-    <!-- Circle -->
-    <circle
-       cx="4650"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle82" />
-    <!-- Circle -->
-    <circle
-       cx="4950"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle84" />
-    <!-- Line: box -->
-    <rect
-       x="750"
-       y="3450"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect86" />
-    <!-- Line: box -->
-    <rect
-       x="300"
-       y="6600"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect88" />
-    <!-- Line: box -->
-    <rect
-       x="3750"
-       y="3450"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect90" />
-    <!-- Line: box -->
-    <rect
-       x="4500"
-       y="5400"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect92" />
-    <!-- Line: box -->
-    <rect
-       x="3300"
-       y="6600"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect94" />
-    <!-- Line: box -->
-    <rect
-       x="2250"
-       y="1650"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect96" />
-    <!-- Line: box -->
-    <rect
-       x="0"
-       y="9300"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect98" />
-    <!-- Line: box -->
-    <rect
-       x="1350"
-       y="8100"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect100" />
-    <!-- Line: box -->
-    <rect
-       x="3000"
-       y="9300"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect102" />
-    <!-- Line: box -->
-    <rect
-       x="4350"
-       y="8100"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect104" />
-    <!-- Line: box -->
-    <rect
-       x="1500"
-       y="5400"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect106" />
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6450"
-       y="300"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text108">rcu_bh</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="3150"
-       y="1950"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text110">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="3150"
-       y="2250"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text112">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1650"
-       y="3750"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text114">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1650"
-       y="4050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text116">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4650"
-       y="4050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text118">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4650"
-       y="3750"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text120">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2250"
-       y="5700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text122">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2250"
-       y="6000"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text124">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="6900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text126">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="7200"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text128">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5250"
-       y="5700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text130">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5250"
-       y="6000"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text132">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="6900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text134">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="7200"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text136">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="450"
-       y="1350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="start"
-       id="text138">struct rcu_state</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="9600"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text140">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="9900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text142">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="9600"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text144">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="9900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text146">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="8400"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text148">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="8700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text150">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="8400"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text152">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="8700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text154">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6000"
-       y="750"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text156">rcu_sched</text>
-    <!-- Line -->
-    <polyline
-       points="5250,5400 5250,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00455750000000066;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline158" />
-    <!-- Arrowhead on XXXpoint 5250 5400 - 5250 4290-->
-  </g>
-</svg>
diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 476b1ac38e4c..f58cd3912918 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -23,8 +23,6 @@ to each other.
 	The <tt>rcu_segcblist</tt> Structure</a>
 <li>	<a href="#The rcu_data Structure">
 	The <tt>rcu_data</tt> Structure</a>
-<li>	<a href="#The rcu_dynticks Structure">
-	The <tt>rcu_dynticks</tt> Structure</a>
 <li>	<a href="#The rcu_head Structure">
 	The <tt>rcu_head</tt> Structure</a>
 <li>	<a href="#RCU-Specific Fields in the task_struct Structure">
@@ -173,17 +171,9 @@ CPUs whose scheduling-clock interrupts have been turned off are
 said to be in <i>dyntick-idle mode</i>.
 RCU must handle dyntick-idle CPUs specially
 because RCU would otherwise wake up each CPU on every grace period,
-which would defeat the whole purpose of <tt>CONFIG_NO_HZ_IDLE</tt>.
-RCU uses the <tt>rcu_dynticks</tt> structure to track
-which CPUs are in dyntick idle mode, as shown below:
-
-</p><p><img src="BigTreeClassicRCUBHdyntick.svg" alt="BigTreeClassicRCUBHdyntick.svg" width="33%">
-
-</p><p>However, if a CPU is in dyntick-idle mode, it is in that mode
-for all flavors of RCU.
-Therefore, a single <tt>rcu_dynticks</tt> structure is allocated per
-CPU, and all of a given CPU's <tt>rcu_data</tt> structures share
-that <tt>rcu_dynticks</tt>, as shown in the figure.
+which would defeat the whole purpose of <tt>CONFIG_NO_HZ_IDLE</tt>.  RCU uses
+the dynticks related fields in the <tt>rcu_data</tt> structure to track which
+CPUs are in dyntick idle mode.
 
 </p><p>Kernels built with <tt>CONFIG_PREEMPT_RCU</tt> support
 rcu_preempt in addition to rcu_sched and rcu_bh, as shown below:
@@ -216,9 +206,6 @@ its own synchronization:
 <li>	Each <tt>rcu_node</tt> structure has a spinlock.
 <li>	The fields in <tt>rcu_data</tt> are private to the corresponding
 	CPU, although a few can be read and written by other CPUs.
-<li>	Similarly, the fields in <tt>rcu_dynticks</tt> are private
-	to the corresponding CPU, although a few can be read by
-	other CPUs.
 </ol>
 
 <p>It is important to note that different data structures can have
@@ -274,11 +261,6 @@ follows:
 	access to this information from the corresponding CPU.
 	Finally, this structure records past dyntick-idle state
 	for the corresponding CPU and also tracks statistics.
-<li>	<tt>rcu_dynticks</tt>:
-	This per-CPU structure tracks the current dyntick-idle
-	state for the corresponding CPU.
-	Unlike the other three structures, the <tt>rcu_dynticks</tt>
-	structure is not replicated per RCU flavor.
 <li>	<tt>rcu_head</tt>:
 	This structure represents RCU callbacks, and is the
 	only structure allocated and managed by RCU users.
@@ -289,8 +271,8 @@ follows:
 <p>If all you wanted from this article was a general notion of how
 RCU's data structures are related, you are done.
 Otherwise, each of the following sections give more details on
-the <tt>rcu_state</tt>, <tt>rcu_node</tt>, <tt>rcu_data</tt>,
-and <tt>rcu_dynticks</tt> data structures.
+the <tt>rcu_state</tt>, <tt>rcu_node</tt> and <tt>rcu_data</tt> data
+structures.
 
 <h3><a name="The rcu_state Structure">
 The <tt>rcu_state</tt> Structure</a></h3>
@@ -1017,30 +999,18 @@ as follows:
 
 <pre>
   1   int cpu;
-  2   struct rcu_state *rsp;
-  3   struct rcu_node *mynode;
-  4   struct rcu_dynticks *dynticks;
-  5   unsigned long grpmask;
-  6   bool beenonline;
+  2   struct rcu_node *mynode;
+  3   unsigned long grpmask;
+  4   bool beenonline;
 </pre>
 
 <p>The <tt>-&gt;cpu</tt> field contains the number of the
-corresponding CPU, the <tt>-&gt;rsp</tt> pointer references
-the corresponding <tt>rcu_state</tt> structure (and is most frequently
-used to locate the name of the corresponding flavor of RCU for tracing),
-and the <tt>-&gt;mynode</tt> field references the corresponding
-<tt>rcu_node</tt> structure.
+corresponding CPU and the <tt>-&gt;mynode</tt> field references the
+corresponding <tt>rcu_node</tt> structure.
 The <tt>-&gt;mynode</tt> is used to propagate quiescent states
 up the combining tree.
-<p>The <tt>-&gt;dynticks</tt> pointer references the
-<tt>rcu_dynticks</tt> structure corresponding to this
-CPU.
-Recall that a single per-CPU instance of the <tt>rcu_dynticks</tt>
-structure is shared among all flavors of RCU.
-These first four fields are constant and therefore require not
-synchronization.
-
-</p><p>The <tt>-&gt;grpmask</tt> field indicates the bit in
+These two fields are constant and therefore donot require synchronization.
+<p>The <tt>-&gt;grpmask</tt> field indicates the bit in
 the <tt>-&gt;mynode-&gt;qsmask</tt> corresponding to this
 <tt>rcu_data</tt> structure, and is also used when propagating
 quiescent states.
@@ -1181,26 +1151,22 @@ Finally, the <tt>-&gt;dynticks_fqs</tt> field is used to
 count the number of times this CPU is determined to be in
 dyntick-idle state, and is used for tracing and debugging purposes.
 
-<h3><a name="The rcu_dynticks Structure">
-The <tt>rcu_dynticks</tt> Structure</a></h3>
-
-<p>The <tt>rcu_dynticks</tt> maintains the per-CPU dyntick-idle state
-for the corresponding CPU.
-Unlike the other structures, <tt>rcu_dynticks</tt> is not
-replicated over the different flavors of RCU.
-The fields in this structure may be accessed only from the corresponding
-CPU (and from tracing) unless otherwise stated.
-Its fields are as follows:
+<p>
+This portion of the rcu_data structure is declared as follows:
 
 <pre>
   1   long dynticks_nesting;
   2   long dynticks_nmi_nesting;
   3   atomic_t dynticks;
   4   bool rcu_need_heavy_qs;
-  5   unsigned long rcu_qs_ctr;
-  6   bool rcu_urgent_qs;
+  5   bool rcu_urgent_qs;
 </pre>
 
+<p>These fields in the rcu_data structure maintain the per-CPU dyntick-idle
+state for the corresponding CPU.
+The fields may be accessed only from the corresponding CPU (and from tracing)
+unless otherwise stated.
+
 <p>The <tt>-&gt;dynticks_nesting</tt> field counts the
 nesting depth of process execution, so that in normal circumstances
 this counter has value zero or one.
@@ -1242,19 +1208,11 @@ it is willing to call for heavy-weight dyntick-counter operations.
 This flag is checked by RCU's context-switch and <tt>cond_resched()</tt>
 code, which provide a momentary idle sojourn in response.
 
-</p><p>The <tt>-&gt;rcu_qs_ctr</tt> field is used to record
-quiescent states from <tt>cond_resched()</tt>.
-Because <tt>cond_resched()</tt> can execute quite frequently, this
-must be quite lightweight, as in a non-atomic increment of this
-per-CPU field.
-
 </p><p>Finally, the <tt>-&gt;rcu_urgent_qs</tt> field is used to record
-the fact that the RCU core code would really like to see a quiescent
-state from the corresponding CPU, with the various other fields indicating
-just how badly RCU wants this quiescent state.
-This flag is checked by RCU's context-switch and <tt>cond_resched()</tt>
-code, which, if nothing else, non-atomically increment <tt>-&gt;rcu_qs_ctr</tt>
-in response.
+the fact that the RCU core code would really like to see a quiescent state from
+the corresponding CPU, with the various other fields indicating just how badly
+RCU wants this quiescent state. This flag is checked by RCU's context-switch path
+(<tt>rcu_note_context_switch</tt>) and the cond_resched code.
 
 <table>
 <tr><th>&nbsp;</th></tr>
@@ -1431,7 +1389,7 @@ So each flavor of RCU is represented by an <tt>rcu_state</tt> structure,
 which contains a combining tree of <tt>rcu_node</tt> and
 <tt>rcu_data</tt> structures.
 Finally, in <tt>CONFIG_NO_HZ_IDLE</tt> kernels, each CPU's dyntick-idle
-state is tracked by an <tt>rcu_dynticks</tt> structure.
+state is tracked by dynticks-related fields in the <tt>rcu_data</tt> structure.
 
 If you made it this far, you are well prepared to read the code
 walkthroughs in the other articles in this series.
-- 
2.19.0.444.g18242da7ef-goog

