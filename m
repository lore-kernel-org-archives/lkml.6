Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2475AC282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08B620870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAVVSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:18:30 -0500
Received: from mleia.com ([178.79.152.223]:58426 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfAVVS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:18:29 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 7B1F343C8BF;
        Tue, 22 Jan 2019 21:18:26 +0000 (GMT)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Meunier <laurent.meunier@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH v2 0/2] pinctrl: remove unused 'pinconf-config' debugfs interface
Date:   Tue, 22 Jan 2019 23:18:20 +0200
Message-Id: <20190122211822.7016-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190122_211826_529769_16AD7941 
X-CRM114-Status: GOOD (  17.22  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal of the change is to remove .pin_config_dbg_parse_modify
callback before a driver with its support appears. So far the in-kernel
interface did not attract any users since its introduction 5 years ago.

Originally .pin_config_dbg_parse_modify callback and the associated
'pinconf-config' debugfs file were introduced in commit f07512e615dd
("pinctrl/pinconfig: add debug interface"), a short description of
'pinconf-config' usage for debugging can be expressed this way:

Write to 'pinconf-config' (see pinconf_dbg_config_write() function):

% echo -n modify $map_type $device_name $state_name $pin_name $config > \
	/sys/kernel/debug/pinctrl/$pinctrl/pinconf-config

It supposes to update a global (therefore single!) 'pinconf_dbg_conf'
variable with an alternative setting, the arguments should match
an existing pinconf device and some registered pinctrl mapping 'map':

* $map_type is either 'config_pin' or 'config_group', it should match
  'map->type' value of PIN_MAP_TYPE_CONFIGS_PIN or
   PIN_MAP_TYPE_CONFIGS_GROUP accordingly,
* $device_name should match 'map->dev_name' string value,
* $state_name should match 'map->name' string value,
* $pin_name should match 'map->data.configs.group_or_pin' string value,

If all above has matched, then $config is a new value to be set by calling
pinconfops->pin_config_dbg_parse_modify(pctldev, config, matched_config).

After a successful write into 'pinconf-config' a user can read the file
to get information about that single modified pin configuration.

The fact is .pin_config_dbg_parse_modify callback has never been defined
in 'struct pinconf_ops' of any pinconf driver, thus an actual modification
of a pin or group state on any present pinconf controller does not happen,
and it declares that all related code is no more than dead code.

I discovered the issue while attempting to add .pin_config_dbg_parse_modify
support in some drivers and found that too short 'MAX_NAME_LEN' set by

  drivers/pinctrl/pinconf.c:372:#define MAX_NAME_LEN 15

is practically insufficient to store a regular pinctrl device name,
which are like 'e6060000.pin-controller-sh-pfc' or pin names like
'MX6QDL_PAD_ENET_REF_CLK', thus it is another indicator that the code
is barely usable, insufficiently tested and unprepossessing.

Of course it might be possible to increase MAX_NAME_LEN, and then add
.pin_config_dbg_parse_modify callbacks to the drivers, but the whole
idea of such a limited debug option looks inviable. A more flexible
way to functionally substitute the original approach is to implicitly
or explicitly use pinctrl_select_state() function whenever needed.

The proposal is to remove the changes added by commit f07512e615dd
("pinctrl/pinconfig: add debug interface") for now, as described in
patch 2/2 commit message it may affect only non-vanilla kernels formally.

Note that still it is a debugfs UAPI change, which is supposed to be
unstable, however, since 'pinconf-config' file is plainly unusable
on vanilla, I won't expect any user reports or asks to restore it back,
this my assumption nudges me not to add an RFC tag to the published
change.

Changes from v1 to v2:
* added one patch against cirrus/pinctrl-madera-core.c to avoid a compile
  time warning due to a removed header inclusion

Vladimir Zapolskiy (2):
  pinctrl: remove pinctrl/machine.h inclusion from pinctrl/pinconf.h
  pinctrl: remove unused 'pinconf-config' debugfs interface

 drivers/pinctrl/cirrus/pinctrl-madera-core.c |   1 +
 drivers/pinctrl/pinconf.c                    | 222 -------------------
 include/linux/pinctrl/pinconf.h              |   6 -
 3 files changed, 1 insertion(+), 228 deletions(-)

-- 
2.20.1

