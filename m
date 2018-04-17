Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDQUCv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 16:02:51 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:46975 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeDQUCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 16:02:49 -0400
X-Google-Smtp-Source: AIpwx4/OUHO9o3P28gX+6mjmdvDPcTCoiaRJFamSfU5rRviCTNkO30hB0LWbubsWMHh0bfmFqTW0dgoFqzGBPF6klJA=
MIME-Version: 1.0
In-Reply-To: <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org> <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Apr 2018 13:02:46 -0700
X-Google-Sender-Auth: g2XcFc7Y-eszzOwZXmoLgw0RVww
Message-ID: <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
> +#define RPMH_REGULATOR_DISABLE                 0x0
> +#define RPMH_REGULATOR_ENABLE                  0x1

In the last version Stephen said he didn't like the above two #defines
and you said you'd remove them, yet they are still here.  Explanation?


> + * @drms_mode:                 Array of regulator framework modes which can
> + *                             be configured dynamically for this regulator
> + *                             via the set_load() callback.

Using the singular for something that is an array is confusing.  Why
not "drms_modes" or "drms_mode_arr"?  In the past review you said
'Perhaps something along the lines of "drms_modes"'.


> +struct rpmh_vreg {
> +       struct rpmh_client              *rpmh_client;
> +       u32                             addr;
> +       struct regulator_desc           rdesc;
> +       const struct rpmh_vreg_hw_data  *hw_data;
> +       enum rpmh_regulator_type        regulator_type;
> +       bool                            always_wait_for_ack;
> +       unsigned int                    *drms_mode;
> +       int                             *drms_mode_max_uA;
> +       size_t                          drms_mode_count;
> +
> +       bool                            enabled;
> +       int                             voltage_selector;
> +       unsigned int                    mode;
> +       bool                            bypassed;

nit: stick next to "enabled" to make slightly better structure packing...


> +static int rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
> +                               unsigned int selector)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       struct tcs_cmd cmd = {
> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
> +       };
> +       int ret;
> +
> +       /* VRM voltage control register is set with voltage in millivolts. */
> +       cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
> +                                                       selector), 1000);
> +
> +       ret = rpmh_regulator_send_request(vreg, &cmd, 1,
> +                                         selector > vreg->voltage_selector);

If you init vreg->voltage_selector to an error as I suggest in
rpmh_regulator_load_default_parameters() you'll need to handle it
here.  See below.


> +static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
> +                                       unsigned int mode, bool bypassed)
> +{
> +       struct tcs_cmd cmd = {
> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
> +       };

Please add:

if (mode & ~(REGULATOR_MODE_STANDBY |
     REGULATOR_MODE_IDLE |
     REGULATOR_MODE_NORMAL |
     REGULATOR_MODE_FAST))
  return -EINVAL;

That way if someone adds a new mode you don't index off the end of
your array.  Ah, I see, you have this in rpmh_regulator_vrm_set_mode
by checking if mode > REGULATOR_MODE_STANDBY.  That works.  Can you
move it here so it's closer to where the array access is?


> +static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       int i;
> +
> +       for (i = 0; i < vreg->drms_mode_count - 1; i++)
> +               if (load_uA < vreg->drms_mode_max_uA[i])
> +                       break;

Can you put a warning here if the requested load_uA is larger than the
largest supported, and/or perhaps consider it an error case?


> +
> +       return rpmh_regulator_vrm_set_mode(rdev, vreg->drms_mode[i]);

Might not hurt to have a comment saying that this calls
rpmh_regulator_vrm_set_mode() instead of calling
rpmh_regulator_vrm_set_mode_bypass() directly because this is supposed
to change the mode returned by a future call to get_mode().


> +static int rpmh_regulator_vrm_set_bypass(struct regulator_dev *rdev,
> +                               bool enable)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       int ret;
> +
> +       if (vreg->bypassed == enable)
> +               return 0;

Just like for enable, remove this check.  The regulator core does it for you.


> +static int rpmh_regulator_vrm_get_bypass(struct regulator_dev *rdev,
> +                               bool *enable)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +       *enable = vreg->bypassed;
> +
> +       return 0;

Should you return an error code if nobody has ever called set_bypass?
...or is it OK to just return "not bypassed"?  Please document this in
the code.


> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg,
> +                               struct device *dev, struct device_node *node)
> +{
> +       const char *prop;
> +       int i, len, ret, mode;
> +       u32 *buf;
> +
> +       /* qcom,allowed-drms-modes is optional */
> +       prop = "qcom,allowed-drms-modes";
> +       len = of_property_count_elems_of_size(node, prop, sizeof(u32));
> +       if (len < 0)
> +               return 0;
> +
> +       vreg->drms_mode = devm_kcalloc(dev, len, sizeof(*vreg->drms_mode),
> +                                       GFP_KERNEL);
> +       vreg->drms_mode_max_uA = devm_kcalloc(dev, len,
> +                                  sizeof(*vreg->drms_mode_max_uA), GFP_KERNEL);
> +       if (!vreg->drms_mode || !vreg->drms_mode_max_uA)
> +               return -ENOMEM;
> +       vreg->drms_mode_count = len;
> +
> +       buf = kcalloc(len, sizeof(*buf), GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       ret = of_property_read_u32_array(node, prop, buf, len);
> +       if (ret < 0) {
> +               dev_err(dev, "%s: unable to read %s, ret=%d\n",
> +                       node->name, prop, ret);
> +               goto done;
> +       }
> +
> +       for (i = 0; i < len; i++) {
> +               mode = vreg->hw_data->of_map_mode(buf[i]);
> +               if (mode <= 0) {

Should be < 0, not <= 0 right?  Unless we take Javier's suggestion
(see <https://patchwork.kernel.org/patch/10346081/>) and make 0 be
invalid...


> +/**
> + * rpmh_regulator_load_default_parameters() - initialize the RPMh resource
> + *             request for this regulator based on optional device tree
> + *             properties
> + * vreg:               Pointer to the individual rpmh-regulator resource
> + * dev:                        Pointer to the top level rpmh-regulator PMIC device
> + * node:               Pointer to the individual rpmh-regulator resource
> + *                     device node
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_load_default_parameters(struct rpmh_vreg *vreg,
> +                               struct device *dev, struct device_node *node)
> +{
> +       struct tcs_cmd cmd[2] = {};
> +       const struct regulator_linear_range *range;
> +       const char *prop;
> +       int cmd_count = 0;
> +       int ret, selector;
> +       u32 uV;
> +
> +       if (vreg->hw_data->regulator_type == VRM) {
> +               prop = "qcom,headroom-voltage";
> +               ret = of_property_read_u32(node, prop, &uV);
> +               if (!ret) {
> +                       if (uV > RPMH_VRM_HEADROOM_MAX_UV) {
> +                               dev_err(dev, "%s: %s=%u is invalid\n",
> +                                       node->name, prop, uV);
> +                               return -EINVAL;
> +                       }
> +
> +                       cmd[cmd_count].addr
> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_HEADROOM;
> +                       cmd[cmd_count++].data = DIV_ROUND_UP(uV, 1000);
> +               }
> +
> +               prop = "qcom,regulator-initial-voltage";
> +               ret = of_property_read_u32(node, prop, &uV);
> +               if (!ret) {
> +                       range = &vreg->hw_data->voltage_range;
> +                       selector = DIV_ROUND_UP(uV - range->min_uV,
> +                                       range->uV_step) + range->min_sel;
> +                       if (uV < range->min_uV || selector > range->max_sel) {
> +                               dev_err(dev, "%s: %s=%u is invalid\n",
> +                                       node->name, prop, uV);
> +                               return -EINVAL;
> +                       }
> +
> +                       vreg->voltage_selector = selector;
> +
> +                       cmd[cmd_count].addr
> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
> +                       cmd[cmd_count++].data
> +                               = DIV_ROUND_UP(selector * range->uV_step
> +                                               + range->min_uV, 1000);
> +               }

Seems like you want an "else { vreg->voltage_selector = -EINVAL; }".
Otherwise "get_voltage_sel" will return selector 0 before the first
set, right?

Previously Mark said: "If the driver can't read values it should
return an appropriate error code."
...and previously you said: "I'll try this out and see if the
regulator framework complains during regulator registration."


> +/**
> + * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
> + * vreg:               Pointer to the individual rpmh-regulator resource
> + * dev:                        Pointer to the top level rpmh-regulator PMIC device
> + * node:               Pointer to the individual rpmh-regulator resource
> + *                     device node
> + * pmic_id:            String used to identify the top level rpmh-regulator
> + *                     PMIC device on the board
> + * rpmh_data:          Pointer to a null-terminated array of rpmh-regulator
> + *                     resources defined for the top level PMIC device
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
> +                               struct device_node *node, const char *pmic_id,
> +                               const struct rpmh_vreg_init_data *rpmh_data)
> +{
> +       struct regulator_config reg_config = {};
> +       char rpmh_resource_name[20] = "";
> +       struct regulator_dev *rdev;
> +       enum rpmh_regulator_type type;
> +       struct regulator_init_data *init_data;
> +       unsigned int mode;
> +       int i, ret;
> +
> +       for (; rpmh_data->name; rpmh_data++)
> +               if (!strcmp(rpmh_data->name, node->name))
> +                       break;
> +
> +       if (!rpmh_data->name) {
> +               dev_err(dev, "Unknown regulator %s\n", node->name);
> +               return -EINVAL;
> +       }
> +
> +       scnprintf(rpmh_resource_name, sizeof(rpmh_resource_name),
> +               rpmh_data->resource_name, pmic_id);

If the resulting string is exactly 20 characters then
rpmh_resource_name won't be zero terminated.  Please handle this
properly.


> +static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {

I may have suggested using this as an array that could be used as a
"map" (index by regulator framework mode and get the PMIC mode), but
now that I see it it doesn't seem super appealing since the regulator
framework mode is not 0, 1, 2, 3 but is actually 1, 2, 4, 8.  ...but I
guess it's not too bad--you're allocating 9 ints to map 4 elements and
I guess that's about as efficient as you're going to get even if it
feels a bit ugly.

...but still a few improvements:

* Don't specify the size of the array as "REGULATOR_MODE_STANDBY + 1".
Let the compiler handle this.  It should do the right thing.  Then if
someone ever changes the order of the #defines things will just work,
I think.

* Make sure that users of these arrays check that the mode is one of
the mode you know about.  That way if someone does add a new mode you
don't index off your array.  I'll put a comment in the user.


Also: the type of this array is 'u32' but you're assigning -EINVAL in
some cases.  Please fix to be signed.  Here and on other similar
arrays.


> +static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int mode)
> +{
> +       static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
> +               [RPMH_REGULATOR_MODE_RET]  = -EINVAL,
> +               [RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
> +               [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
> +               [RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
> +       };

You're sticking a negative value in an array of unsigned inits.  Here
and in other similar functions.

I know, I know.  The function is defined to return an unsigned int.
It's wrong.  of_regulator.c clearly puts the return code in a signed
int.  First attempt at fixing this is at
<https://patchwork.kernel.org/patch/10346081/>.


> +static const struct rpmh_vreg_hw_data pmic4_bob = {
> +       .regulator_type = VRM,
> +       .ops = &rpmh_regulator_vrm_bypass_ops,
> +       .voltage_range = REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
> +       .n_voltages = 84,
> +       .pmic_mode_map = pmic_mode_map_pmic4_bob,
> +       .of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
> +       .bypass_mode = 0,

Remove .bypass_mode from the structure and just change
rpmh_regulator_vrm_set_mode_bypass() to set 0 if we're in bypass.
Right now 100% of PMICs that support bypass use 0 as the bypass mode.
If you ever have a future PMIC that uses a non-zero mode for bypass
then we can always add this back.  ...and if no future PMICs ever use
a non-zero bypass mode then we don't need the complexity of having
another field in this struct.

If you don't do this you might get arguments from some people saying
that they don't like seeing inits of "= 0" in static structures (Linux
conventions seem to like you to just assume that structs are
zero-initted).


> +static int rpmh_regulator_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct rpmh_vreg_init_data *vreg_data;
> +       struct rpmh_client *rpmh_client;
> +       struct device_node *node;
> +       struct rpmh_vreg *vreg;
> +       const char *pmic_id;
> +       int ret;
> +
> +       ret = cmd_db_ready();
> +       if (ret < 0) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
> +               return ret;
> +       }

In the last patch Stephen said:

> We should just make rpmh parent device call cmd_db_ready() so that these
> devices aren't even populated until then and so that cmd_db_ready() is
> only in one place. Lina?

Any news here?


> +
> +       vreg_data = of_device_get_match_data(dev);
> +       if (!vreg_data)
> +               return -ENODEV;
> +
> +       ret = of_property_read_string(dev->of_node, "qcom,pmic-id", &pmic_id);
> +       if (ret < 0) {
> +               dev_err(dev, "qcom,pmic-id missing in DT node\n");
> +               return ret;
> +       }
> +
> +       rpmh_client = rpmh_get_client(pdev);
> +       if (IS_ERR(rpmh_client))
> +               return PTR_ERR(rpmh_client);
> +       platform_set_drvdata(pdev, rpmh_client);
> +
> +       for_each_available_child_of_node(dev->of_node, node) {
> +               vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
> +               if (!vreg) {
> +                       ret = -ENOMEM;
> +                       of_node_put(node);
> +                       goto cleanup;
> +               }
> +
> +               vreg->rpmh_client = rpmh_client;
> +
> +               ret = rpmh_regulator_init_vreg(vreg, dev, node, pmic_id,
> +                                               vreg_data);
> +               if (ret < 0) {
> +                       of_node_put(node);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       return 0;
> +
> +cleanup:
> +       rpmh_release(rpmh_client);

Still no devm_rpmh_get_client()?  If Lina is too busy spinning her
patch series for other stuff, just add it to RPMH as a patch in your
series.  I believe it's just this (untested):

---

int devm_rpmh_release(struct device *dev, void *res)
{
  struct platform_device *pdev = to_platform_device(dev);
  rpmh_release(pdev);
}

int devm_rpmh_get_client(struct device *dev)
{
  struct platform_device *pdev = to_platform_device(dev);
  void *dr;
  int rc;

  dr = devres_alloc(devm_rpmh_release, 0, GFP_KERNEL);
  if (!dr)
    return -ENOMEM;

  rc = rpmh_get_client(pdev);
  if (!rc)
    devres_add(dev, dr);
  else
    devres_free(dr);

  return rc;
}

---

Note that you'll get rid of the error handling in probe, the whole
remove function, and the need to do platform_set_drvdata().


-Doug
