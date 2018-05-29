Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeE2KTr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:19:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbeE2KTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:19:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFB30605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
To: David Collins <collinsd@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-6-rnayak@codeaurora.org>
 <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <6f8e5fe2-199d-ba1f-19d7-2faf276075f3@codeaurora.org>
Date: Tue, 29 May 2018 15:49:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 05/26/2018 06:38 AM, David Collins wrote:
> Hello Rajendra,
> 
> On 05/25/2018 03:01 AM, Rajendra Nayak wrote:
>> The RPMh powerdomain driver aggregates the corner votes from various
> 
> s/powerdomain/power domain/
> 
> This applies to all instances in this patch.  "Power domain" seems to be
> the preferred spelling in the kernel.

thanks, will change in all applicable places.

> 
> 
>> consumers for the ARC resources and communicates it to RPMh.
>>
>> We also add data for all powerdomains on sdm845 as part of the patch.
>> The driver can be extended to support other SoCs which support RPMh
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  .../devicetree/bindings/power/qcom,rpmhpd.txt |  65 ++++
>>  drivers/soc/qcom/Kconfig                      |   9 +
>>  drivers/soc/qcom/Makefile                     |   1 +
>>  drivers/soc/qcom/rpmhpd.c                     | 360 ++++++++++++++++++
>>  4 files changed, 435 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>>  create mode 100644 drivers/soc/qcom/rpmhpd.c
> ...
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
> 
> I think that this binding documentation should be in a patch separate from
> the driver.

yes, will split it when I repost

> 
> 
>> @@ -0,0 +1,65 @@
>> +Qualcomm RPMh Powerdomains
> 
> s/Qualcomm/Qualcomm Technologies, Inc./
> 
> 
>> +
>> +* For RPMh powerdomains, we communicate a performance state to RPMh
> 
> Does this line need to start with '*'?

No, will remove it

> 
> 
>> +which then translates it into a corresponding voltage on a rail
>> +
>> +Required Properties:
>> + - compatible: Should be one of the following
>> +	* qcom,sdm845-rpmhpd: RPMh powerdomain for the sdm845 family of SoC
>> + - power-domain-cells: number of cells in power domain specifier
>> +	must be 1
>> + - operating-points-v2: Phandle to the OPP table for the power-domain.
>> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
>> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
>> +
>> +Example:
>> +
>> +	rpmhpd: power-controller {
>> +		compatible = "qcom,sdm845-rpmhpd";
>> +		#power-domain-cells = <1>;
>> +		operating-points-v2 = <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>,
>> +				      <&rpmhpd_opp_table>;
> 
> Can this be changed to simply:
>   operating-points-v2 = <&rpmhpd_opp_table>;
> 
> The opp binding documentation [1] states that this should be ok:
> 
>     If only one phandle is available, then the same OPP table will be used
>     for all power domains provided by the power domain provider.

thanks, I mentioned this to Viresh but didn't realize he fixed it up.
Will remove the redundant entries.

> 
> 
>> +	};
>> +
>> +	rpmhpd_opp_table: opp-table {
>> +		compatible = "operating-points-v2-qcom-level", "operating-points-v2";
>> +
>> +		rpmhpd_opp1: opp@1 {
> 
> Is there any significance to the 1 through 8 values in these OPP table
> nodes?  If not, then could this be changed to something like:
> 
> rpmhpd_retention: opp@16 {
> ...
> rpmhpd_turbo_l1: opp@416 {
> 
> 
>> +			qcom-corner = <16>;
> 
> s/qcom-corner/qcom,level/g

Thanks, I'll fix these up.
> 
> 
>> +		};
>> +
>> +		rpmhpd_opp2: opp@2 {
>> +			qcom-corner = <48>;
>> +		};
>> +
>> +		rpmhpd_opp3: opp@3 {
>> +			qcom-corner = <64>;
>> +		};
>> +
>> +		rpmhpd_opp4: opp@4 {
>> +			qcom-corner = <128>;
>> +		};
>> +
>> +		rpmhpd_opp5: opp@5 {
>> +			qcom-corner = <192>;
>> +		};
>> +
>> +		rpmhpd_opp6: opp@6 {
>> +			qcom-corner = <256>;
>> +		};
>> +
>> +		rpmhpd_opp7: opp@7 {
>> +			qcom-corner = <320>;
>> +		};
> 
> Can you please add 336 and 384 to your example?  384 at least should be
> present as it corresponds to the Turbo level which all supplies support.

will do.

> 
> 
>> +		rpmhpd_opp8: opp@8 {
>> +			qcom-corner = <416>;
>> +		};
>> +	};
> 
> How are consumers of these power domains supposed to identify which domain
> within <&rpmhpd> to use (e.g. VDD_CX vs VDD_MX)?  If the answer is a plain
> integer index, then could you please add per-platform #define constants in
> a DT header file which explicitly define the meaning for each index?
> 
> How do consumers of these power domains identify which level they want to
> set for a specific power domain (e.g. Nominal vs Turbo)?
> 
> Would it be helpful to provide a DT header file with #define constants for
> the cross-platform sparse level mapping?  This is done in [2] for the
> downstream rpmh-regulator driver that handles ARC managed regulators.
> 
> 
> Would it be ok to add some consumer DT nodes in this binding file example
> so that it is clear how consumers interact with the rpmhpd?

yes, I'll add the header for indexes and performance levels.

> 
> 
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a7a405178967..1faed239701d 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -74,6 +74,15 @@ config QCOM_RMTFS_MEM
>>  
>>  	  Say y here if you intend to boot the modem remoteproc.
>>  
>> +config QCOM_RPMHPD
>> +	tristate "Qualcomm RPMh Powerdomain driver"
> 
> s/Qualcomm/Qualcomm Technologies, Inc./

All other config options in qcom/Kconfig use 'Qualcomm XYZ feature'
for the comment. Maybe I will leave it that way for consistency?

[]...

>> +
>> +struct rpmhpd {
>> +	struct device *dev;
>> +	struct generic_pm_domain pd;
>> +	struct rpmhpd *peer;
>> +	const bool active_only;
>> +	unsigned long corner;
> 
> Does this actually need to be unsigned long?  It looks like unsigned int
> is being passed in from rpmhpd_set_performance().  Also, hlvl values sent
> to RPMh will only every be in the range 0 - 15.
> 
> If you change the type here, then can you also please change long to int
> in to_active_sleep() and rpmhpd_aggregate_corner() below?

yes, there's no need for an unsigned long, will change it

> 
> 
>> +	u32	level[RPMH_ARC_MAX_LEVELS];
>> +	int	level_count;
>> +	bool enabled;
>> +	const char *res_name;
>> +	u32	addr;
>> +};
> 
> Can you please indent the fields of this struct to the same column with tabs?

will do.

> 
> 
>> +
>> +struct rpmhpd_desc {
>> +	struct rpmhpd **rpmhpds;
>> +	size_t num_pds;
>> +};
> 
> This struct could be removed and the per-platform arrays could instead be
> NULL terminated.

Yes, but I would prefer it this way unless you have strong objections.
Just makes it easier to do the allocations at probe for genpd_onecell_data structures.

>> +
>> +static DEFINE_MUTEX(rpmhpd_lock);
>> +
>> +/* sdm845 RPMh powerdomains */
>> +DEFINE_RPMHPD(sdm845, ebi);
>> +DEFINE_RPMHPD_AO(sdm845, mx, mx_ao);
>> +DEFINE_RPMHPD_AO(sdm845, cx, cx_ao);
>> +DEFINE_RPMHPD(sdm845, lmx);
>> +DEFINE_RPMHPD(sdm845, lcx);
>> +DEFINE_RPMHPD(sdm845, gfx);
>> +DEFINE_RPMHPD(sdm845, mss);
>> +
>> +static struct rpmhpd *sdm845_rpmhpds[] = {
>> +	[0] = &sdm845_ebi,
> 
> If you are going to explicitly index these elements, then can you please
> use #define constants from a DT header file that specifies meaningful
> names?  The existing 0-8 indexing is no better than implicit indexing.

yes, I will use the macros from the header.

> 
> 
>> +	[1] = &sdm845_mx,
>> +	[2] = &sdm845_mx_ao,
>> +	[3] = &sdm845_cx,
>> +	[4] = &sdm845_cx_ao,
>> +	[5] = &sdm845_lmx,
>> +	[6] = &sdm845_lcx,
>> +	[7] = &sdm845_gfx,
>> +	[8] = &sdm845_mss,
>> +};
>> +
>> +static const struct rpmhpd_desc sdm845_desc = {
>> +	.rpmhpds = sdm845_rpmhpds,
>> +	.num_pds = ARRAY_SIZE(sdm845_rpmhpds),
>> +};
>> +
>> +static const struct of_device_id rpmhpd_match_table[] = {
>> +	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
>> +
>> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state, unsigned int corner)
>> +{
>> +	struct tcs_cmd cmd = {
>> +		.addr = pd->addr,
>> +		.data = corner,
>> +	};
>> +
>> +	return rpmh_write(pd->dev, state, &cmd, 1);
> 
> This can be optimized by calling rpmh_write_async() whenever the corner
> being sent is smaller than the last value sent.  That way, no time is
> wasted waiting for an ACK when decreasing voltage.  Would you mind adding
> the necessary check and previous request caching for this?

thanks, looks useful, I will do the necessary changes.

> 
> 
>> +};
>> +
>> +static void to_active_sleep(struct rpmhpd *pd, unsigned long corner,
>> +			    unsigned long *active, unsigned long *sleep)
>> +{
>> +	*active = corner;
>> +
>> +	if (pd->active_only)
>> +		*sleep = 0;
>> +	else
>> +		*sleep = *active;
>> +}
>> +
>> +static int rpmhpd_aggregate_corner(struct rpmhpd *pd)
>> +{
>> +	int ret;
>> +	struct rpmhpd *peer = pd->peer;
>> +	unsigned long active_corner, sleep_corner;
>> +	unsigned long this_corner = 0, this_sleep_corner = 0;
>> +	unsigned long peer_corner = 0, peer_sleep_corner = 0;
> 
> s/this_corner/this_active_corner/
> s/peer_corner/peer_active_corner/
> 
> This is more consistent and I think that it makes the code a little more
> readable.

sure

> 
> 
>> +
>> +	to_active_sleep(pd, pd->corner, &this_corner, &this_sleep_corner);
>> +
>> +	if (peer && peer->enabled)
>> +		to_active_sleep(peer, peer->corner, &peer_corner,
>> +				&peer_sleep_corner);
>> +
>> +	active_corner = max(this_corner, peer_corner);
>> +
>> +	ret = rpmhpd_send_corner(pd, RPMH_ACTIVE_ONLY_STATE, active_corner);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
>> +
>> +	return rpmhpd_send_corner(pd, RPMH_SLEEP_STATE, sleep_corner);
>> +}
> 
> This aggregation function as well as the rpmhpd_send_corner() calls below
> are not sufficient for RPMh.  There are 3 states that must all be used:
> RPMH_ACTIVE_ONLY_STATE, RPMH_WAKE_ONLY_STATE, and RPMH_SLEEP_STATE.  The
> naming is somewhat confusing as rpmhpd is defining a different concept of
> active-only.
> 
> For power domains without active-only or peers, only
> RPMH_ACTIVE_ONLY_STATE should be used.  This instructs RPMh to issue the
> request immediately.
> 
> For power domains with active-only, requests will need to be made for all
> three.  active_corner would be sent for both RPMH_ACTIVE_ONLY_STATE (so
> that the request takes effect immediately) and RPMH_WAKE_ONLY_STATE (so
> that the request is inserted into the wake TCS).  sleep_corner would be
> sent for RPMH_SLEEP_STATE (so that the request is inserted into the sleep
> TCS).
> 
> You can see how this is handled in the RPMh clock driver in patch [3].

Thanks, I'll take another look at this and fix this up

> 
> You may be able to get away with using only RPMH_SLEEP_STATE and
> RPMH_ACTIVE_ONLY_STATE assuming that you issue the RPMH_SLEEP_STATE
> request first due to the rpmh driver caching behavior added in the
> cache_rpm_request() function in [4].  However, could you please confirm
> with Lina that this usage will continue to work in the future?  I'm not
> sure what guarantees are made at the rpmh API level.

sure, I'll check it up

> 
> 
>> +
>> +static int rpmhpd_power_on(struct generic_pm_domain *domain)
>> +{
>> +	int ret = 0;
>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
> 
> Minor: It might look a little nicer to list 'pd' definition first amongst
> the local variables in this function as well as those below.

okay

> 
> 
>> +
>> +	mutex_lock(&rpmhpd_lock);
>> +
>> +	pd->enabled = true;
>> +
>> +	if (pd->corner)
>> +		ret = rpmhpd_aggregate_corner(pd);
>> +
>> +	mutex_unlock(&rpmhpd_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmhpd_power_off(struct generic_pm_domain *domain)
>> +{
>> +	int ret;
>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
>> +
>> +	mutex_lock(&rpmhpd_lock);
>> +
>> +	if (pd->level[0] == 0) {
>> +		ret = rpmhpd_send_corner(pd, RPMH_ACTIVE_ONLY_STATE, 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = rpmhpd_send_corner(pd, RPMH_SLEEP_STATE, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	pd->enabled = false;
>> +
>> +	mutex_unlock(&rpmhpd_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rpmhpd_set_performance(struct generic_pm_domain *domain,
>> +			     unsigned int state)
>> +{
>> +	int ret = 0;
>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
>> +
>> +	mutex_lock(&rpmhpd_lock);
>> +
>> +	pd->corner = state;
> 
> What is the numbering space for 'state'?  I assume that it is a vlvl value
> corresponding to qcom,level in a DT OPP table node.  If so, additional
> logic is required.
> 
> When using RPMh, the platform and supply independent vlvl sparse numbering
> space is used by consumers so that they can always have consistent values.
>  However, the actual requests sent to RPMh ARC must be in the hlvl
> numbering space (i.e. 0 - 15(max)).  In the case of this driver, the
> acceptable hlvl values for a given power domain are 0 to pd->level_count - 1.
> 
> I suspect that you need to add something like this here:
> 
> int i;
> 
> for (i = 0; i < pd->level_count; i++)
> 	if (state <= pd->level[i])
> 		break;
> 
> if (i == pd->level_count) {
> 	ret = -EINVAL;
> 	dev_err(pd->dev, "invalid state=%u for domain %s",
> 		state, pd->pd.name);
> 	goto out;
> }
> 
> pd->corner = i;
> 
> 
> Note that a given power domain will likely not support all of the vlvl
> values listed in the DT OPP table nodes.

yes indeed :/ I will add the translation bits here for vlvl to hlvl which is
needed before communicating with RPMh

> 
> 
>> +
>> +	if (!pd->enabled)
>> +		goto out;
>> +
>> +	ret = rpmhpd_aggregate_corner(pd);
>> +out:
>> +	mutex_unlock(&rpmhpd_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static unsigned int rpmhpd_get_performance(struct generic_pm_domain *genpd,
>> +					   struct dev_pm_opp *opp)> +{
>> +	struct device_node *np;
>> +	unsigned int corner = 0;
>> +
>> +	np = dev_pm_opp_get_of_node(opp);
>> +	if (of_property_read_u32(np, "qcom,level", &corner)) {
>> +		pr_err("%s: missing 'qcom,level' property\n", __func__);
>> +		return 0;
> 
> Why return 0 instead of an error?

The caller expects a 0 for failure

> 
> 
>> +	}
>> +
>> +	of_node_put(np);
>> +
>> +	return corner;
>> +}
> 
> Is there an API to determine the currently operating performance state of
> a given power domain?  Is this information accessible from userspace?  We
> will definitely need this for general debugging.

A quick look shows me its not. I agree its a necessary feature for debug.
I will add a patch to expose it via debugfs

> 
> 
>> +
>> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>> +{
>> +	u8 *buf;
> 
> This could be changed to the following in order to remove the need for
> kzalloc() and kfree() calls below:
> 
> u8 buf[RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE];
> 
> 
>> +	int i, j, len, ret;
>> +
>> +	len = cmd_db_read_aux_data_len(rpmhpd->res_name);
>> +	if (len <= 0)
>> +		return len;
>> +
> 
> A check like this is needed here:
> 
> if (len > RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE)
> 	return -EINVAL;
> 
> 
>> +	buf = kzalloc(len, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	ret = cmd_db_read_aux_data(rpmhpd->res_name, buf, len);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	rpmhpd->level_count = len / RPMH_ARC_LEVEL_SIZE;
>> +
>> +	for (i = 0; i < rpmhpd->level_count; i++) {
> 
> If you make buf a fixed size array, then rpmhpd->level[i] = 0; is needed
> here or a memset() outside of the for loop.

Okay, I;ll move buf to a fixed size array instead

> 
> 
>> +		for (j = 0; j < RPMH_ARC_LEVEL_SIZE; j++)
>> +			rpmhpd->level[i] |=
>> +				buf[i * RPMH_ARC_LEVEL_SIZE + j] << (8 * j);
>> +
>> +		/*
>> +		 * The AUX data may be zero padded.  These 0 valued entries at
>> +		 * the end of the map must be ignored.
>> +		 */
>> +		if (i > 0 && rpmhpd->level[i] == 0) {
>> +			rpmhpd->level_count = i;
>> +			break;
>> +		}
>> +		pr_dbg("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
>> +		       rpmhpd->level[i]);
>> +	}
>> +
>> +	kfree(buf);
>> +	return 0;
>> +}
>> +
>> +static int rpmhpd_probe(struct platform_device *pdev)
>> +{
>> +	int i, ret;
>> +	size_t num;
>> +	struct genpd_onecell_data *data;
>> +	struct rpmhpd **rpmhpds;
>> +	const struct rpmhpd_desc *desc;
>> +
>> +	desc = of_device_get_match_data(&pdev->dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	rpmhpds = desc->rpmhpds;
>> +	num = desc->num_pds;
>> +
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
>> +				     GFP_KERNEL);
>> +	data->num_domains = num;
>> +
>> +	ret = cmd_db_ready();
>> +	if (ret) {
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(&pdev->dev, "Command DB unavailable, ret=%d\n",
>> +				ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < num; i++) {
>> +		if (!rpmhpds[i])
>> +			continue;
> 
> Why is this check needed?

Just to check/ignore if there are any holes.
maybe I should atleast throw a warning instead of silently ignoring it?

> 
> 
>> +
>> +		rpmhpds[i]->dev = &pdev->dev;
>> +		rpmhpds[i]->addr = cmd_db_read_addr(rpmhpds[i]->res_name);
>> +		if (!rpmhpds[i]->addr) {
>> +			dev_err(&pdev->dev, "Could not find RPMh address for resource %s\n",
>> +				rpmhpds[i]->res_name);
>> +			return -ENODEV;
>> +		}
>> +
>> +		ret = cmd_db_read_slave_id(rpmhpds[i]->res_name);
>> +		if (ret != CMD_DB_HW_ARC) {
>> +			dev_err(&pdev->dev, "RPMh slave ID mismatch\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		ret = rpmhpd_update_level_mapping(rpmhpds[i]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		rpmhpds[i]->pd.power_off = rpmhpd_power_off;
>> +		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
>> +		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance;
>> +		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance;
>> +		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>> +
>> +		data->domains[i] = &rpmhpds[i]->pd;
>> +	}
>> +
>> +	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>> +}
>> +
>> +static int rpmhpd_remove(struct platform_device *pdev)
>> +{
>> +	of_genpd_del_provider(pdev->dev.of_node);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver rpmhpd_driver = {
>> +	.driver = {
>> +		.name = "qcom-rpmhpd",
>> +		.of_match_table = rpmhpd_match_table,
>> +	},
>> +	.probe = rpmhpd_probe,
>> +	.remove = rpmhpd_remove,
>> +};
>> +
>> +static int __init rpmhpd_init(void)
>> +{
>> +	return platform_driver_register(&rpmhpd_driver);
>> +}
>> +core_initcall(rpmhpd_init);
>> +
>> +static void __exit rpmhpd_exit(void)
>> +{
>> +	platform_driver_unregister(&rpmhpd_driver);
>> +}
>> +module_exit(rpmhpd_exit);
>> +
>> +MODULE_DESCRIPTION("Qualcomm RPMh Power Domain Driver");
> 
> s/Qualcomm/Qualcomm Technologies, Inc./

will do

> 
> 
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:qcom-rpmhpd");
> 
> Thanks,
> David

Thanks David for taking time to review.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
