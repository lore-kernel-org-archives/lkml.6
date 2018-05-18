Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeERKcB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:32:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43790 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbeERKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:31:56 -0400
X-Google-Smtp-Source: AB8JxZpQtY/3mk2mu2NoKbovx7CxdsdaBwJLVXwKQnQEVUBi57Jtmko0CQE781wg3SUvya9Yvn69tw==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 5/9] PM / Domains: dt: Allow power-domain property to be a list of phandles
Date: Fri, 18 May 2018 12:31:26 +0200
Message-Id: <1526639490-12167-6-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to describe topologies where devices are partitioned across
multiple power domains, let's extend the power-domain property to allow
being a list of phandles.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/power/power_domain.txt         | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 4733f76..b27ae7f 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -111,8 +111,9 @@ Example 3:
 ==PM domain consumers==
 
 Required properties:
- - power-domains : A phandle and PM domain specifier as defined by bindings of
-                   the power controller specified by phandle.
+ - power-domains : A phandle and PM domain specifier, or a list of phandles, as
+		   defined by bindings of the power controller specified by
+		   phandle.
 
 Example:
 
@@ -122,9 +123,16 @@ Example:
 		power-domains = <&power 0>;
 	};
 
-The node above defines a typical PM domain consumer device, which is located
-inside a PM domain with index 0 of a power controller represented by a node
-with the label "power".
+	leaky-device@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&power0 0>, <&power1 0> ;
+	};
+
+The first example above defines a typical PM domain consumer device, which is
+located inside a PM domain with index 0 of a power controller represented by a
+node with the label "power". In the second example the consumer device are
+partitioned across two PM domains.
 
 Optional properties:
 - required-opps: This contains phandle to an OPP node in another device's OPP
-- 
2.7.4
