Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeDPU5x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:57:53 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41877 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeDPU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:57:51 -0400
X-Google-Smtp-Source: AIpwx4/coda6B6gGAoAE8eBQGciZW85pMIJdvCoLTnZrHUgtJSjfSgayi01HTlPix7MinyzpEbR6Aw==
Date: Mon, 16 Apr 2018 15:57:49 -0500
From: Rob Herring <robh@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180416205749.556rbkzaja33oref@rob-hp-laptop>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 07:50:34PM -0700, David Collins wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 207 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 ++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
>  create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
> new file mode 100644
> index 0000000..69748ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
> @@ -0,0 +1,207 @@
> +Qualcomm Technologies, Inc. RPMh Regulators
> +
> +rpmh-regulator devices support PMIC regulator management via the Voltage
> +Regulator Manager (VRM) and Oscillator Buffer (XOB) RPMh accelerators.  The APPS
> +processor communicates with these hardware blocks via a Resource State
> +Coordinator (RSC) using command packets.  The VRM allows changing four
> +parameters for a given regulator: enable state, output voltage, operating mode,
> +and minimum headroom voltage.  The XOB allows changing only a single parameter
> +for a given regulator: its enable state.  Despite its name, the XOB is capable
> +of controlling the enable state of any PMIC peripheral.  It is used for clock
> +buffers, low-voltage switches, and LDO/SMPS regulators which have a fixed
> +voltage and mode.
> +
> +=======================
> +Required Node Structure
> +=======================
> +
> +RPMh regulators must be described in two levels of device nodes.  The first
> +level describes the PMIC containing the regulators and must reside within an
> +RPMh device node.  The second level describes each regulator within the PMIC
> +which is to be used on the board.  Each of these regulators maps to a single
> +RPMh resource.
> +
> +The names used for regulator nodes must match those supported by a given PMIC.
> +Supported regulator node names:
> +	PM8998:		smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
> +	PMI8998:	bob
> +	PM8005:		smps1 - smps4
> +
> +========================
> +First Level Nodes - PMIC
> +========================
> +
> +- compatible
> +	Usage:      required
> +	Value type: <string>
> +	Definition: Must be one of: "qcom,pm8998-rpmh-regulators",
> +		    "qcom,pmi8998-rpmh-regulators" or
> +		    "qcom,pm8005-rpmh-regulators".
> +
> +- qcom,pmic-id
> +	Usage:      required
> +	Value type: <string>
> +	Definition: RPMh resource name suffix used for the regulators found on
> +		    this PMIC.  Typical values: "a", "b", "c", "d", "e", "f".
> +
> +- vdd_s1-supply

Use '-' rather than '_' on all these.

> +- vdd_s2-supply
> +- vdd_s3-supply
> +- vdd_s4-supply
> +- vdd_s5-supply
> +- vdd_s6-supply
> +- vdd_s7-supply
> +- vdd_s8-supply
> +- vdd_s9-supply
> +- vdd_s10-supply
> +- vdd_s11-supply
> +- vdd_s12-supply
> +- vdd_s13-supply
> +- vdd_l1_l27-supply
> +- vdd_l2_l8_l17-supply
> +- vdd_l3_l11-supply
> +- vdd_l4_l5-supply
> +- vdd_l6-supply
> +- vdd_l7_l12_l14_l15-supply
> +- vdd_l9-supply
> +- vdd_l10_l23_l25-supply
> +- vdd_l13_l19_l21-supply
> +- vdd_l16_l28-supply
> +- vdd_l18_l22-supply
> +- vdd_l20_l24-supply
> +- vdd_l26-supply
> +- vdd_lvs1_lvs2-supply
> +- vdd_lvs1_lvs2-supply
> +	Usage:      optional (PM8998 only)
> +	Value type: <phandle>
> +	Definition: phandle of the parent supply regulator of one or more of the
> +		    regulators for this PMIC.
> +
> +- vdd_bob-supply
> +	Usage:      optional (PMI8998 only)
> +	Value type: <phandle>
> +	Definition: BOB regulator parent supply phandle
> +
> +- vdd_s1-supply
> +- vdd_s2-supply
> +- vdd_s3-supply
> +- vdd_s4-supply

Listed twice?

> +	Usage:      optional (PM8005 only)
> +	Value type: <phandle>
> +	Definition: phandle of the parent supply regulator of one or more of the
> +		    regulators for this PMIC.
> +
> +===============================
> +Second Level Nodes - Regulators
> +===============================
> +
> +- qcom,regulator-initial-voltage
> +	Usage:      optional; VRM regulators only
> +	Value type: <u32>
> +	Definition: Specifies the initial voltage in microvolts to request for a
> +		    VRM regulator.
> +
> +- regulator-initial-mode

Vendor prefix?

> +	Usage:      optional; VRM regulators only
> +	Value type: <u32>
> +	Definition: Specifies the initial mode to request for a VRM regulator.
> +		    Supported values are RPMH_REGULATOR_MODE_* which are defined
> +		    in [1] (i.e. 0 to 3).  This property may be specified even
> +		    if the regulator-allow-set-load property is not specified.
> +
> +- qcom,allowed-drms-modes
> +	Usage:      required if regulator-allow-set-load is specified;
> +		    VRM regulators only
> +	Value type: <prop-encoded-array>
> +	Definition: A list of integers specifying the PMIC regulator modes which
> +		    can be configured at runtime based upon consumer load needs.
> +		    Supported values are RPMH_REGULATOR_MODE_* which are defined
> +		    in [1] (i.e. 0 to 3).
> +
> +- qcom,drms-mode-threshold-currents
> +	Usage:      required if regulator-allow-set-load is specified;
> +		    VRM regulators only
> +	Value type: <prop-encoded-array>
> +	Definition: A list of integers specifying the maximum allowed load
> +		    current in microamps for each of the modes listed in
> +		    qcom,allowed-drms-modes (matched 1-to-1 in order).  Elements
> +		    must be specified in order from lowest to highest value.
> +
> +- qcom,headroom-voltage
> +	Usage:      optional; VRM regulators only
> +	Value type: <u32>
> +	Definition: Specifies the headroom voltage in microvolts to request for
> +		    a VRM regulator.  RPMh hardware automatically ensures that
> +		    the parent of this regulator outputs a voltage high enough
> +		    to satisfy the requested headroom.  Supported values are
> +		    0 to 511000.
> +
> +- qcom,always-wait-for-ack
> +	Usage:      optional
> +	Value type: <empty>
> +	Definition: Boolean flag which indicates that the application processor
> +		    must wait for an ACK or a NACK from RPMh for every request
> +		    sent for this regulator including those which are for a
> +		    strictly lower power state.
> +
> +Other properties defined in Documentation/devicetree/bindings/regulator.txt
> +may also be used.
> +
> +[1] include/dt-bindings/regulator/qcom,rpmh-regulator.h
> +
> +========
> +Examples
> +========
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +&apps_rsc {
> +	pm8998-rpmh-regulators {
> +		compatible = "qcom,pm8998-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd_l7_l12_l14_l15-supply = <&pm8998_s5>;
> +
> +		smps2 {
> +			regulator-min-microvolt = <1100000>;
> +			regulator-max-microvolt = <1100000>;
> +			qcom,regulator-initial-voltage = <1100000>;
> +		};
> +
> +		pm8998_s5: smps5 {
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2040000>;
> +			qcom,regulator-initial-voltage = <1904000>;
> +		};
> +
> +		ldo7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			qcom,regulator-initial-voltage = <1800000>;
> +			qcom,headroom-voltage = <56000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +			regulator-allow-set-load;
> +			qcom,allowed-drms-modes =
> +				<RPMH_REGULATOR_MODE_LPM
> +				 RPMH_REGULATOR_MODE_HPM>;
> +			qcom,drms-mode-threshold-currents = <10000 1000000>;
> +		};
> +
> +		lvs1 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +	};
> +
> +	pmi8998-rpmh-regulators {
> +		compatible = "qcom,pmi8998-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		bob {
> +			regulator-min-microvolt = <3312000>;
> +			regulator-max-microvolt = <3600000>;
> +			qcom,regulator-initial-voltage = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +};
> diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
> new file mode 100644
> index 0000000..4378c4b
> --- /dev/null
> +++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +
> +#ifndef __QCOM_RPMH_REGULATOR_H
> +#define __QCOM_RPMH_REGULATOR_H
> +
> +/*
> + * These mode constants may be used for regulator-initial-mode and
> + * qcom,allowed-drms-modes properties of an RPMh regulator device tree node.
> + * Each type of regulator supports a subset of the possible modes.
> + *
> + * %RPMH_REGULATOR_MODE_RET:	Retention mode in which only an extremely small
> + *				load current is allowed.  This mode is supported
> + *				by LDO and SMPS type regulators.
> + * %RPMH_REGULATOR_MODE_LPM:	Low power mode in which a small load current is
> + *				allowed.  This mode corresponds to PFM for SMPS
> + *				and BOB type regulators.  This mode is supported
> + *				by LDO, HFSMPS, BOB, and PMIC4 FTSMPS type
> + *				regulators.
> + * %RPMH_REGULATOR_MODE_AUTO:	Auto mode in which the regulator hardware
> + *				automatically switches between LPM and HPM based
> + *				upon the real-time load current.  This mode is
> + *				supported by HFSMPS, BOB, and PMIC4 FTSMPS type
> + *				regulators.
> + * %RPMH_REGULATOR_MODE_HPM:	High power mode in which the full rated current
> + *				of the regulator is allowed.  This mode
> + *				corresponds to PWM for SMPS and BOB type
> + *				regulators.  This mode is supported by all types
> + *				of regulators.
> + */
> +#define RPMH_REGULATOR_MODE_RET		0
> +#define RPMH_REGULATOR_MODE_LPM		1
> +#define RPMH_REGULATOR_MODE_AUTO	2
> +#define RPMH_REGULATOR_MODE_HPM		3
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
