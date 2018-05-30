Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968982AbeE3Joo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:44:44 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38158 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965077AbeE3Jol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:44:41 -0400
X-Google-Smtp-Source: ADUXVKLE3k7AZ9PJhYl7U6SIV5t+40jIB6TfBTn6lbZDBEO8MiD1PLDnegMB6Nv734x+Twp7U9jdPA==
Date: Wed, 30 May 2018 15:14:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: David Collins <collinsd@codeaurora.org>, sboyd@kernel.org,
        andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
Message-ID: <20180530094438.xnyukvhum7tc6roh@vireshk-i7>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-6-rnayak@codeaurora.org>
 <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
 <6f8e5fe2-199d-ba1f-19d7-2faf276075f3@codeaurora.org>
 <36822404-bdf5-1915-03e7-e5ffcff05c9b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36822404-bdf5-1915-03e7-e5ffcff05c9b@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-18, 14:25, Rajendra Nayak wrote:
> []...
> 
> >>> +Required Properties:
> >>> + - compatible: Should be one of the following
> >>> +	* qcom,sdm845-rpmhpd: RPMh powerdomain for the sdm845 family of SoC
> >>> + - power-domain-cells: number of cells in power domain specifier
> >>> +	must be 1
> >>> + - operating-points-v2: Phandle to the OPP table for the power-domain.
> >>> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
> >>> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
> >>> +
> >>> +Example:
> >>> +
> >>> +	rpmhpd: power-controller {
> >>> +		compatible = "qcom,sdm845-rpmhpd";
> >>> +		#power-domain-cells = <1>;
> >>> +		operating-points-v2 = <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>,
> >>> +				      <&rpmhpd_opp_table>;
> >>
> >> Can this be changed to simply:
> >>   operating-points-v2 = <&rpmhpd_opp_table>;
> >>
> >> The opp binding documentation [1] states that this should be ok:
> >>
> >>     If only one phandle is available, then the same OPP table will be used
> >>     for all power domains provided by the power domain provider.
> > 
> > thanks, I mentioned this to Viresh but didn't realize he fixed it up.
> > Will remove the redundant entries.
> 
> Looks like the kernel implementation does not handle this yet, and I get
> an error adding the OPP tables for the powerdomains if I just specify
> a single OPP table phandle.
> 
> Viresh, is this expected with the latest patches in linux-next?
> 
> It would be good if I can specify just one phandle instead of coping
> the same phandle n times. 

Please try this untested hunk:

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 6d15f05bfc28..7af0ddec936b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -554,11 +554,24 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
        struct device_node *opp_np;
-       int ret;
+       int ret, count;
 
+again:
        opp_np = _opp_of_get_opp_desc_node(dev->of_node, index);
-       if (!opp_np)
+       if (!opp_np) {
+               /*
+                * If only one phandle is present, then the same OPP table
+                * applies for all index requests.
+                */
+               count = of_count_phandle_with_args(dev->of_node,
+                                                  "operating-points-v2", NULL);
+               if (count == 1 && index) {
+                       index = 0;
+                       goto again;
+               }
+
                return -ENODEV;
+       }
 
        ret = _of_add_opp_table_v2(dev, opp_np);
        of_node_put(opp_np);
