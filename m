Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933197AbeE2KEw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:04:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54773 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeE2KEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:04:37 -0400
X-Google-Smtp-Source: AB8JxZoUmLU2Qxs3zDSRshLWegb/wHhLEQDZKm9FgRfhKMHuXHEncGNVpvhTmO+4ay3TZw6CBHNLCQ==
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
Subject: [PATCH v2 5/9] PM / Domains: dt: Allow power-domain property to be a list of specifiers
Date: Tue, 29 May 2018 12:04:17 +0200
Message-Id: <20180529100421.31022-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529100421.31022-1-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to describe topologies where devices are partitioned across
multiple power domains, let's extend the power-domain property to allow
being a list of PM domain specifiers.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Fixed comments from Geert. Re-worded to "PM domain specifiers" and
	clarified DT example.

---
 .../bindings/power/power_domain.txt           | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 4733f76cbe48..9b387f861aed 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -111,8 +111,8 @@ Example 3:
 ==PM domain consumers==
 
 Required properties:
- - power-domains : A phandle and PM domain specifier as defined by bindings of
-                   the power controller specified by phandle.
+ - power-domains : A list of PM domain specifiers, as defined by bindings of
+		the power controller that is the PM domain provider.
 
 Example:
 
@@ -122,9 +122,18 @@ Example:
 		power-domains = <&power 0>;
 	};
 
-The node above defines a typical PM domain consumer device, which is located
-inside a PM domain with index 0 of a power controller represented by a node
-with the label "power".
+	leaky-device@12351000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12351000 0x1000>;
+		power-domains = <&power 0>, <&power 1> ;
+	};
+
+The first example above defines a typical PM domain consumer device, which is
+located inside a PM domain with index 0 of a power controller represented by a
+node with the label "power".
+In the second example the consumer device are partitioned across two PM domains,
+the first with index 0 and the second with index 1, of a power controller that
+is represented by a node with the label "power.
 
 Optional properties:
 - required-opps: This contains phandle to an OPP node in another device's OPP
-- 
2.17.0
