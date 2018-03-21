Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCUCQc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:16:32 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35647 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeCUCQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:16:23 -0400
X-Google-Smtp-Source: AG47ELt75nna01pe/s3hnK9HXHQ/38bvauksStqrKMHBkwhJxTqT18oQNRLe+51lQuYXjLzJi6++ufRQFlozos9UDQs=
MIME-Version: 1.0
In-Reply-To: <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org> <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 20 Mar 2018 19:16:20 -0700
X-Google-Sender-Auth: klHb_gXw8kCL4Nryz0ko_0ek0eY
Message-ID: <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm@lists.infradead.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 16, 2018 at 6:09 PM, David Collins <collinsd@codeaurora.org> wrote:
> +/**
> + * struct rpmh_regulator_mode - RPMh VRM mode attributes
> + * @pmic_mode:                 Raw PMIC mode value written into VRM mode voting
> + *                             register (i.e. RPMH_REGULATOR_MODE_*)
> + * @framework_mode:            Regulator framework mode value
> + *                             (i.e. REGULATOR_MODE_*)
> + * @min_load_ua:               The minimum load current in microamps which
> + *                             would utilize this mode

Thinking of this as "min load" seems backward to me.  Shouldn't we be
keeping track of "max load".  AKA:

Use "idle" if the load is less than 1000 mA
Use "normal" if the load is more than 1000 mA but less than 5000 mA
Use "fast" if the load is more than 5000 mA.

I'd think of "1000 mA as the max load that "idle" can handle".  The
reason I don't think of it as "min" is that you can't say "1000 mA is
the min load the "normal" can handle".  Normal can handle smaller
loads just fine, it's just not ideal.


Thinking of it in terms of "max" would also get rid of that weird
"needs to be 0" entry in the device tree too.  You could either leave
the number off the top one (and set to INT_MAX in software?) or you
could use that to put in some sort of sane maximum current.  I'd bet
there's something in the datasheet for this.  If someone in software
got mixed up and kept requesting more and more current, this could
catch their error.



> +static int rpmh_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +       return vreg->enabled;

You can't read hardware?  The regulator framework expects you to read
hardware.  If it was common not to be able to read hardware then the
regulator framework would just keep track of the enabled state for
you.  Right now if a regulator was left on by the BIOS (presumably
some have to be since otherwise you're running on a computer that
takes no power), you'll still return false at bootup?  Seems
non-ideal.


> +}
> +
> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       struct tcs_cmd cmd = {
> +               .addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +               .data = RPMH_REGULATOR_ENABLE,
> +       };
> +       int ret;
> +
> +       if (vreg->enabled)
> +               return 0;

Does the "if" test above ever hit?  I'd think the regulator framework
would handle this.


> +static int rpmh_regulator_disable(struct regulator_dev *rdev)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       struct tcs_cmd cmd = {
> +               .addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +               .data = RPMH_REGULATOR_DISABLE,
> +       };
> +       int ret;
> +
> +       if (!vreg->enabled)
> +               return 0;

Does the "if" test above ever hit?  I'd think the regulator framework
would handle this.


> +static int rpmh_regulator_vrm_set_voltage(struct regulator_dev *rdev,
> +                               int min_uv, int max_uv, unsigned int *selector)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       struct tcs_cmd cmd = {
> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
> +       };
> +       const struct regulator_linear_range *range;
> +       int mv, uv, ret;
> +       bool wait_for_ack;
> +
> +       mv = DIV_ROUND_UP(min_uv, 1000);
> +       uv = mv * 1000;
> +       if (uv > max_uv) {
> +               vreg_err(vreg, "no set points available in range %d-%d uV\n",
> +                       min_uv, max_uv);
> +               return -EINVAL;
> +       }
> +
> +       range = vreg->hw_data->voltage_range;
> +       *selector = DIV_ROUND_UP(uv - range->min_uV, range->uV_step);

It seems like you should remove the existing check you have for "if
(uv > max_uv)" and replace with a check here.  Specifically, it seems
like the DIV_ROUND_UP for the selector could also bump you over the
max.  AKA:

...
bool wait_for_ack;

range = vreg->hw_data->voltage_range;
*selector = DIV_ROUND_UP(min_uv - range->min_uV, range->uV_step);
uv = *selector * range->uV_step + range->min_uV
if (uv > max_uv) {
  ...
}


Hold up, though.  Why don't you implement set_voltage_sel() instead of
set_voltage()?  That's what literally everyone else does, well except
PWM regulators.  Using that will get rid of most of this code, won't
it?  Even the check to see if perhaps the voltage isn't changing.


> +
> +       if (uv == vreg->voltage)
> +               return 0;
> +
> +       wait_for_ack = uv > vreg->voltage || max_uv < vreg->voltage;

Do you often see "wait_for_ack = false" in reality?  Most regulator
usage I've seen requests a fairly tight range.  AKA: I don't often
see:

  set_voltage(min=3000mV, max=3300mV)
  set_voltage(min=1800mV, max=3300mV)

Instead, I see:

  set_voltage(min=3000mV, max=3300mV)
  set_voltage(min=1800mV, max=1900mV)

So you'll always have wait_for_ack = true in the cases I've seen.

...but are you certain it's useful to wait for an ack anyway when the
voltage is falling?  Most regulators won't guarantee that the voltage
has actually fallen even after they ack you.  Specifically if a
regulator is under light load and it doesn't have an active discharge
circuit then the regulator might fall very slowly over time.  As a
specific example, see commit 7c5209c315ea ("mmc: core: Increase delay
for voltage to stabilize from 3.3V to 1.8V").


That was a lot of words, so to sum it all up:

* If you have no actual examples where you see "wait_for_ack = false"
then remove this code and always wait.

* If you have evidence that the time spent waiting for the ack is
slowing you down, consider always setting wait_for_ack to false when
you're lowering the voltage.  Anyone who truly cares could just set
something like the device tree property
regulator-settling-time-down-us.  ...or, assuming Mark doesn't hate
it, they could set the always-wait-for-ack property in the device
tree.


NOTE: I think you don't use VRMs for DVFS anyway (you use the fancy
ARC things for this?), we're probably talking about a small handful of
voltage transitions per boot, right?


> +static int rpmh_regulator_vrm_get_voltage(struct regulator_dev *rdev)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +       return vreg->voltage;

I guess there's no way to read the voltage at bootup?  So this will
return 0 until someone sets it?  ...maybe less of a big deal due to
the "qcom,regulator-initial-voltage" property?


> +static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
> +                                       unsigned int mode)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       struct tcs_cmd cmd = {
> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
> +       };
> +       int i, ret;
> +
> +       if (mode == vreg->mode)
> +               return 0;
> +
> +       for (i = 0; i < RPMH_REGULATOR_MODE_COUNT; i++)
> +               if (vreg->hw_data->mode_map[i].framework_mode == mode)
> +                       break;
> +       if (i >= RPMH_REGULATOR_MODE_COUNT) {
> +               vreg_err(vreg, "invalid mode=%u\n", mode);
> +               return -EINVAL;
> +       }
> +
> +       cmd.data = vreg->hw_data->mode_map[i].pmic_mode;
> +
> +       ret = rpmh_regulator_send_request(vreg, &cmd, 1,
> +                                         mode < vreg->mode || !vreg->mode);

Please explain the "mode < vreg->mode || !vreg->mode" test in words.


> +static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +       return vreg->mode;

You'll probably guess that I'd expect you to read this from hardware.


> +/**
> + * rpmh_regulator_parse_vrm_modes() - parse the supported mode configurations
> + *             for a VRM RPMh resource from device tree
> + * vreg:               Pointer to the rpmh regulator resource
> + *
> + * This function initializes the mode[] array of vreg based upon the values
> + * of optional device tree properties.
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg)
> +{
> +       struct device_node *node = vreg->of_node;
> +       const struct rpmh_regulator_mode *map;
> +       const char *prop;
> +       int i, len, ret;
> +       u32 *buf;
> +
> +       map = vreg->hw_data->mode_map;
> +       if (!map)
> +               return 0;
> +
> +       /* qcom,allowed-modes is optional */
> +       prop = "qcom,allowed-modes";
> +       len = of_property_count_elems_of_size(node, prop, sizeof(u32));
> +       if (len < 0)
> +               return 0;

Seems like it might be worth it to count
"qcom,mode-threshold-currents" too and confirm the count is the same?
If someone left in an extra threshold current you won't notice
otherwise (right?)


> +
> +       vreg->mode_map = devm_kcalloc(vreg->pmic->dev, len,
> +                               sizeof(*vreg->mode_map), GFP_KERNEL);

I keep getting myself confused because you have two things called
"mode_map" and they work differently:

vreg->mode_map - contains 1 element per allowed mode.  Need to iterate
through this to map "framework mode" to "pmic mode".  Note: because of
the need to iterate this isn't really a "map" in my mind.

vreg->hw_data->mode_map - contains 1 element for each possible "device
tree mode".  Index into this using "device tree mode" and you get both
a "framework mode" and "pmic mode".


IMHO it would be better to have a table like "dt_to_linux_mode" that
was just a simple list:

static const int dt_to_linux_mode_bob[] = [
 [RPMH_REGULATOR_MODE_PASS] = REGULATOR_MODE_STANDBY,
 [RPMH_REGULATOR_MODE_RET] = -EINVAL,
 [RPMH_REGULATOR_MODE_LPM] = REGULATOR_MODE_IDLE,
 [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
 [RPMH_REGULATOR_MODE_HPM] = REGULATOR_MODE_FAST
];

static const int dt_to_linux_mode_ldo_smps[] =
 [RPMH_REGULATOR_MODE_PASS] = -EINVAL,
 [RPMH_REGULATOR_MODE_RET] = REGULATOR_MODE_STANDBY,
 [RPMH_REGULATOR_MODE_LPM] = REGULATOR_MODE_IDLE,
 [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
 [RPMH_REGULATOR_MODE_HPM] = REGULATOR_MODE_FAST
];

You'd only use that in the "map_mode" functions and when parsing
qcom,allowed-modes.  ...and, in fact, parsing qcom,allowed-modes could
actually just call the map_mode function.  This would be especially a
good way to do this if you moved "allowed-modes" into the regulator
core, which seems like a good idea.

The nice thing about this is that only place you need to conceptually
keep track of RPMH_REGULATOR_MODE_XYZ is in the device tree parsing
code.  Otherwise you just think of the Linux version.

---

Once you do the above, then your other list could just be named
"allowed_modes".  This would make it obvious that this isn't a map
itself but that you could iterate over it to accomplish a mapping.


> +/**
> + * rpmh_regulator_allocate_vreg() - allocate space for the regulators associated
> + *             with the PMIC and initialize important pointers for each
> + *             regulator
> + * @pmic:              Pointer to the RPMh regulator PMIC
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_allocate_vreg(struct rpmh_pmic *pmic)
> +{
> +       struct device_node *node;
> +       int i;
> +
> +       pmic->vreg_count = of_get_available_child_count(pmic->dev->of_node);
> +       if (pmic->vreg_count == 0) {
> +               dev_err(pmic->dev, "could not find any regulator subnodes\n");
> +               return -ENODEV;
> +       }
> +
> +       pmic->vreg = devm_kcalloc(pmic->dev, pmic->vreg_count,
> +                       sizeof(*pmic->vreg), GFP_KERNEL);
> +       if (!pmic->vreg)
> +               return -ENOMEM;
> +
> +       i = 0;
> +       for_each_available_child_of_node(pmic->dev->of_node, node) {
> +               pmic->vreg[i].of_node = node;
> +               pmic->vreg[i].pmic = pmic;
> +
> +               i++;
> +       }

While I can believe that things don't crash, you're not quite using
for_each_available_child_of_node() correctly.  You need to reorganize
your code structure to fix.  Specifically the "node" that's provided
to each iteration only has its refcount held for each iteration.  By
the end of your function the refcount of all the "of_node"s that you
stored wil be 0.  Doh.

You could try to fix this by adding a of_node_get() before storing the
node and that would work, but that would complicate your error
handling.  You'll need to do this in a "cleanup" error path of probe
and in remove.  :(

A better solution is to get rid of the rpmh_regulator_allocate_vreg()
function and move the functionality into probe.  There, instead of
iterating over pmic->vreg_count, just use the
for_each_available_child_of_node() function.  If
rpmh_regulator_init_vreg() you'll have to manually of_node_put() but
that should be OK.

Why will that work?  You'll call rpmh_regulator_init_vreg() while the
reference count is still held.  In that function you'll call
devm_regulator_register(), which will grab the refcount if it needs
it.  Since that's a devm_ function you can be sure that it will
properly drop the refcount at the right times.

NOTE: with this you presumably should remove the "of_node" from the
"struct rpmh_vreg".  It seems like it shouldn't be needed anymore and
it's good not to keep the pointer around if you didn't call
of_node_get() yourself.


> +/**
> + * rpmh_regulator_load_default_parameters() - initialize the RPMh resource
> + *             request for this regulator based on optional device tree
> + *             properties
> + * @vreg:              Pointer to the RPMh regulator
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_load_default_parameters(struct rpmh_vreg *vreg)
> +{
> +       struct tcs_cmd cmd[2] = { };
> +       const char *prop;
> +       int cmd_count = 0;
> +       int ret;
> +       u32 temp;
> +
> +       if (vreg->regulator_type == RPMH_REGULATOR_TYPE_VRM) {
> +               prop = "qcom,headroom-voltage";
> +               ret = of_property_read_u32(vreg->of_node, prop, &temp);
> +               if (!ret) {
> +                       if (temp < RPMH_VRM_HEADROOM_MIN_UV ||
> +                           temp > RPMH_VRM_HEADROOM_MAX_UV) {
> +                               vreg_err(vreg, "%s=%u is invalid\n",
> +                                       prop, temp);
> +                               return -EINVAL;
> +                       }
> +                       vreg->headroom_voltage = temp;
> +
> +                       cmd[cmd_count].addr
> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_HEADROOM;
> +                       cmd[cmd_count++].data
> +                               = DIV_ROUND_UP(vreg->headroom_voltage, 1000);
> +               }
> +
> +               prop = "qcom,regulator-initial-voltage";
> +               ret = of_property_read_u32(vreg->of_node, prop, &temp);
> +               if (!ret) {
> +                       if (temp < RPMH_VRM_MIN_UV || temp > RPMH_VRM_MAX_UV) {
> +                               vreg_err(vreg, "%s=%u is invalid\n",
> +                                       prop, temp);
> +                               return -EINVAL;
> +                       }
> +                       vreg->voltage = temp;
> +
> +                       cmd[cmd_count].addr
> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
> +                       cmd[cmd_count++].data
> +                               = DIV_ROUND_UP(vreg->voltage, 1000);

It seems like you should set vreg->voltage to the actual result of the
division * 1000.  AKA: if the user said the initial voltage was
123,456 then vreg->voltage should become 124,000.

Actually, shouldn't you somehow resolve this with "struct
rpmh_vreg_hw_data".  It seems like some regulators have 128 steps,
some have 256 steps, etc.  You should have a function that reconciles
the requested voltage with the one that hardware will actually
provide.

...and, actually, you should share code for this reconciliation with
rpmh_regulator_vrm_set_voltage().


> +/**
> + * rpmh_regulator_init_vreg() - initialize all abbributes of an rpmh-regulator
> + * @vreg:              Pointer to the RPMh regulator
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg)
> +{
> +       struct device *dev = vreg->pmic->dev;
> +       struct regulator_config reg_config = {};
> +       const struct rpmh_vreg_init_data *rpmh_data = NULL;
> +       const char *type_name = NULL;
> +       enum rpmh_regulator_type type;
> +       struct regulator_init_data *init_data;
> +       int ret, i;
> +
> +       for (i = 0; i < vreg->pmic->init_data->count; i++) {
> +               if (!strcmp(vreg->pmic->init_data->vreg_data[i].name,
> +                           vreg->of_node->name)) {
> +                       rpmh_data = &vreg->pmic->init_data->vreg_data[i];
> +                       break;
> +               }
> +       }
> +
> +       if (!rpmh_data) {
> +               dev_err(dev, "Unknown regulator %s for %s RPMh regulator PMIC\n",
> +                       vreg->of_node->name, vreg->pmic->init_data->name);
> +               return -EINVAL;
> +       }
> +
> +       vreg->resource_name = devm_kasprintf(dev, GFP_KERNEL, "%s%s%d",
> +                       rpmh_data->resource_name_base, vreg->pmic->pmic_id,
> +                       rpmh_data->id);
> +       if (!vreg->resource_name)
> +               return -ENOMEM;
> +
> +       vreg->addr = cmd_db_read_addr(vreg->resource_name);
> +       if (!vreg->addr) {
> +               vreg_err(vreg, "could not find RPMh address for resource %s\n",
> +                       vreg->resource_name);
> +               return -ENODEV;
> +       }
> +
> +       vreg->rdesc.name = rpmh_data->name;
> +       vreg->rdesc.supply_name = rpmh_data->supply_name;
> +       vreg->regulator_type = rpmh_data->regulator_type;
> +       vreg->hw_data = rpmh_data->hw_data;
> +
> +       if (rpmh_data->hw_data->voltage_range) {
> +               vreg->rdesc.linear_ranges = rpmh_data->hw_data->voltage_range;
> +               vreg->rdesc.n_linear_ranges = 1;
> +               vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
> +       }
> +
> +       /* Optional override for the default RPMh accelerator type */
> +       ret = of_property_read_string(vreg->of_node, "qcom,rpmh-resource-type",
> +                                       &type_name);
> +       if (!ret) {
> +               if (!strcmp("vrm", type_name)) {
> +                       vreg->regulator_type = RPMH_REGULATOR_TYPE_VRM;
> +               } else if (!strcmp("xob", type_name)) {
> +                       vreg->regulator_type = RPMH_REGULATOR_TYPE_XOB;
> +               } else {
> +                       vreg_err(vreg, "Unknown RPMh accelerator type %s\n",
> +                               type_name);
> +                       return -EINVAL;
> +               }

As per comment in device tree patch, it seems really weird that you
can override this.  Are you sure?


> +static const struct rpmh_regulator_mode
> +rpmh_regulator_mode_map_pmic4_bob[RPMH_REGULATOR_MODE_COUNT] = {
> +       [RPMH_REGULATOR_MODE_PASS] = {
> +               .pmic_mode = 0,
> +               .framework_mode = REGULATOR_MODE_STANDBY,

Is "PASS" truly the same concept as the Linux concept of STANDBY.  If
so, why do you need a separate define for it?

If it truly is the same, it seems like you can simplify everything by
just changing your defines.  Get rid of "RPMH_REGULATOR_MODE_RET" and
"RPMH_REGULATOR_MODE_PASS" and just call it
"RPMH_REGULATOR_MODE_STANDBY".  You can add comments saying that
"standby" maps to "retention" for some regulators and maps to "pass"
for other regulators if you want to map PMIC documentation.  ...but
getting rid of this distinction simply means less error checking and
fewer tables in Linux.

If "pass" really shouldn't map to "standby" then this seems like a
hack and you should add the concept of "pass" to the core regulator
framework.


> +static const struct rpmh_vreg_hw_data pmic4_pldo_hw_data = {
> +       .voltage_range = &(const struct regulator_linear_range)
> +                       REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),

This seems pretty iffy to me.  You're relying on the compiler to make
an anonymous chunk of memory with a "struct regulator_linear_range" in
it and then storing a pointer to said anonymous chunk of memory?
Nobody else using REGULATOR_LINEAR_RANGE() does this.

Why not just get rid of the pointer and put the structure right inside
"struct rpmh_vreg_hw_data"?  It'll get rid of the weird cast / strange
anonymous chunk, save an indirection, and save 4 bytes for a pointer.


> +/**
> + * rpmh_regulator_probe() - probe an RPMh PMIC and register regulators for each
> + *             of the regulator nodes associated with it
> + * @pdev:              Pointer to the platform device of the RPMh PMIC
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct of_device_id *match;
> +       struct rpmh_pmic *pmic;
> +       struct device_node *node;
> +       int ret, i;
> +
> +       node = dev->of_node;
> +
> +       if (!node) {
> +               dev_err(dev, "Device tree node is missing\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = cmd_db_ready();
> +       if (ret < 0) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
> +               return ret;
> +       }
> +
> +       pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> +       if (!pmic)
> +               return -ENOMEM;
> +
> +       pmic->dev = dev;
> +       platform_set_drvdata(pdev, pmic);
> +
> +       pmic->rpmh_client = rpmh_get_client(pdev);

It seems like you'd do yourself (and the other clients of rpmh) a
favor if you added a devm_rpmh_get_client() in a patch before this
one.  Adding a devm version of a calls is pretty easy and you'll be
able to completely get rid of your "remove" function.  ...and get rid
of the "cleanup" exit here.


> +static struct platform_driver rpmh_regulator_driver = {
> +       .driver         = {
> +               .name           = "qcom-rpmh-regulator",
> +               .of_match_table = rpmh_regulator_match_table,
> +               .owner          = THIS_MODULE,

As per the robot, no need to set .owner here. The core will do it.


> +       },
> +       .probe          = rpmh_regulator_probe,
> +       .remove         = rpmh_regulator_remove,
> +};
> +
> +static int rpmh_regulator_init(void)
> +{
> +       return platform_driver_register(&rpmh_regulator_driver);
> +}
> +
> +static void rpmh_regulator_exit(void)
> +{
> +       platform_driver_unregister(&rpmh_regulator_driver);
> +}
> +
> +arch_initcall(rpmh_regulator_init);

I always get yelled at when I try to use arch_initcall() for stuff
like this.  You should do what everyone else does and use
module_platform_driver() to declare your driver.  Yeah, regulators are
important and (as I remember) they get probed slightly early anyway,
but everything else in the system just gotta deal with the fact that
they'll sometimes get deferred probes.


> +module_exit(rpmh_regulator_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm RPMh regulator driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
> new file mode 100644
> index 0000000..f854e0e
> --- /dev/null
> +++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h

Device tree guys will yell at you here.  The "include/dt-bindings"
bits are supposed to be together with the bindings.  Different
maintainers have different beliefs here, but I think the way that's
least likely to get you yelled at by the most people is:

Patch #1: bindings (.txt and include file)
Patch #2: the driver

...with the idea being that if another operating system wanted just
the bindings they could get it all in one patch.


> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +
> +#ifndef __QCOM_RPMH_REGULATOR_H
> +#define __QCOM_RPMH_REGULATOR_H
> +
> +/*
> + * These mode constants may be used for qcom,allowed-modes and qcom,init-mode

Not "qcom,init-mode".  This is actually "regulator-initial-mode" now.


> + * properties of an RPMh resource.  Each type of regulator supports a subset of
> + * the possible modes.
> + *
> + * %RPMH_REGULATOR_MODE_PASS:  Pass-through mode in which output is directly
> + *                             tied to input.  This mode is only supported by
> + *                             BOB type regulators.
> + * %RPMH_REGULATOR_MODE_RET:   Retention mode in which only an extremely small
> + *                             load current is allowed.  This mode is supported
> + *                             by LDO and SMPS type regulators.
> + * %RPMH_REGULATOR_MODE_LPM:   Low power mode in which a small load current is
> + *                             allowed.  This mode corresponds to PFM for SMPS
> + *                             and BOB type regulators.  This mode is supported
> + *                             by LDO, HFSMPS, BOB, and PMIC4 FTSMPS type
> + *                             regulators.
> + * %RPMH_REGULATOR_MODE_AUTO:  Auto mode in which the regulator hardware
> + *                             automatically switches between LPM and HPM based
> + *                             upon the real-time load current.  This mode is
> + *                             supported by HFSMPS, BOB, and PMIC4 FTSMPS type
> + *                             regulators.
> + * %RPMH_REGULATOR_MODE_HPM:   High power mode in which the full rated current
> + *                             of the regulator is allowed.  This mode
> + *                             corresponds to PWM for SMPS and BOB type
> + *                             regulators.  This mode is supported by all types
> + *                             of regulators.
> + */
> +#define RPMH_REGULATOR_MODE_PASS       0
> +#define RPMH_REGULATOR_MODE_RET                1
> +#define RPMH_REGULATOR_MODE_LPM                2
> +#define RPMH_REGULATOR_MODE_AUTO       3
> +#define RPMH_REGULATOR_MODE_HPM                4
> +
> +#endif


OK, I think that's enough for one review session.  Looking forward to
seeing responses / the next version.  Let me know if anything I said
looks wrong or if you have questions!  :)

-Doug
