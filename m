Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C28C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923542151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="saX56vNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923542151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeHUSCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:02:16 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:30703
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeHUSCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/zu3UVjKAAG9wRg/ucv5ZplgUMPMm9fF6y/aMUyIMg=;
 b=saX56vNKzje/sMFfoBD1C7mk0iyW2txk2yQ2RrYhfwW16t5dX2UvAkljvVA6vjcT0hUbnwsOCq/Faiy38KrxdVqVtNC3T0XVeL2iw8VXgJOGysGQ170mPAj5gw2DH+Kexd6kJo+rNSzcG6m4OW2b0CUMgQcA4h0AC/z0lajzJ6Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM6PR04MB4661.eurprd04.prod.outlook.com (2603:10a6:20b:1b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 14:40:56 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH 0/2] pwm: imx: Configure output to GPIO in disabled state
Date:   Tue, 21 Aug 2018 16:38:51 +0200
Message-Id: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: HE1PR0301CA0012.eurprd03.prod.outlook.com
 (2603:10a6:3:76::22) To AM6PR04MB4661.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 213d2520-c21a-438c-af99-08d607741e42
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4661;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;3:6Cn0/ZCs7+J0tzekv74Qpkd9tMR9VxHLqnHZlH69OuQYpU8yEi/A+Ed9xcahMsl+lpsU3+CM2vHA2rLmkb9cPLUJIj7HORoRYJjbKMtzPQxjeAspkC6LkpuZI3bjfy7K3JnLgFVroFCCjh310cdPY5I3z6fihhE4/9hT2FEXoYaEdm0SFG7xESsRDaklvtnI4zk1g9HnBV3zHOOjUYUTvjlNnXeHq2qQwUboQwAB6eBSl3IiMHenPdXBJZNCtjeV;25:3M+NkqEyKKH4ti/b1CqpisNVsUH4x38Xg4i+Vi7CrsjmEkvVnGiPHdiy7UmNU915YCXpLB/NkOdZyiAcWldoZiAR8rxv07XpLCNAH+gD8gGM8/SxY6IsFwenhRyDWH3qCg+BsSsJEtyUIdYRszJY4uL8Ic/ZV7Exg9fwAJWXYKps0IpGZUUVc/ctKCJfL26Mv8Z4LuT85NZGfWk0A9vPwsV3hrVDEjrgeA/x1D/h9FICjpVKV3xRWQPowFyQMPyWeTO42Ux9oibA7MuY2KHz4C127aSFohD/hsWrnQCOFB0xZ/ijlQMleCRFpueP1U126pf4Nf+LF67PzUn9SXZugw==;31:7aWplc1TNoL9ABlCalOUQU8VjRD6edvK6GHGDFL7GuCnQpUVUVduwKwujW2gmQCR0kOGaUVLKSkKbtuHFnt5NhwiPHkeddU47Pwy3979ZffSADfYVUEddeMSwHZhmLPhsqT4VtoazcPjFoVGIhZ484h0vsgYCeXjFX79AE/hkjMB90Ccv0tdko5Xct238NR88PoExAqQol+CYPvJZrqCpnU9J4+dhqKk9e0jsaAXKSE=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4661:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;20:zY+F7W7IAkd3WKEu6Kmav546wxtSqdEfISm5OdrIBYc8Wa/BuASn3nSpUw0LSuyhXdQLyPVz4R/5lvsSDW6fHx1fKDI3Q9nXxPR2RBy0E8RkHQhmmqWRytse3c2nrrBHS/R//1gXCGcCojXXh81NhWqJM33SJyEKCr3Sfs07ea5VPoRjNitTvW1+SonsA36r+9iTa69FNUcozIkQA9m205lbFs1YbmyQePJuXu/htvOFkKf/UcpKAN7nOu/HJnyb;4://n7R6mO+NOwYSJwgiGJ6lVFyKmUesY5GlKqrJs0GkIMxfP4sw3guSx062RXXwGGPdcd6/E6AuTdxZIrzOxy3BufEDezdaqdXfacQI6KYg+5Hgoknf/SE7e1MOOGo29Qk8ctr7POnzS9x48Ix9ytoKzVktYRwwZ0h6RItEk0lrlEzNUnl3ARwj0jZmVbQP6Tpmo6v5Nc6agDXEFcj2SPHKi3PeJTpMAIaU5cnBrEWtm77qYp84A6o98AtRgelQA7XNvAVP6SU1aH3BqHNr4R8w==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4661567B588777B27D405DF29E310@AM6PR04MB4661.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR04MB4661;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4661;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(7736002)(39060400002)(107886003)(2870700001)(2906002)(25786009)(23676004)(52116002)(54906003)(106356001)(50466002)(110136005)(305945005)(6666003)(105586002)(4326008)(86362001)(316002)(72206003)(6506007)(217873002)(66066001)(81166006)(81156014)(8676002)(47776003)(2616005)(6486002)(14444005)(6512007)(6306002)(486006)(53936002)(6116002)(476003)(956004)(26005)(68736007)(8936002)(478600001)(50226002)(966005)(36756003)(186003)(386003)(97736004)(16526019)(5660300001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4661;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYxOzIzOnErWkZCOHpraTZIRkg2c2FHSmY1L1hIeUxI?=
 =?utf-8?B?WHJuTVNYRC9jc3lsNjNBTk9IVk4yTWI2MFArRnpYRThGUnQwY1k1NlhaL0pz?=
 =?utf-8?B?YmJRVHYyOUdrV091OEcxSGxyWHZzQzFjUlZvVkdwci9UVHBMb3Nla0Q5TEJu?=
 =?utf-8?B?MXh6SDRjZmxleFpDNjFMRnFnQTVkZGordzdLUWc3ZzVLMVZDTitUanR6bTNO?=
 =?utf-8?B?dVU0UUNkMWh6blVSRUUzYnpMcXJyQWVyNzk3ZDFnQ3hTNEJ6SEhCNlA0SHY3?=
 =?utf-8?B?YkZaZ0RYaThzMTdqN280L3llYVRaT0VFa1ZiakRibkJlZCsvYW5lTC9meWJ2?=
 =?utf-8?B?dUdUbHFGZ3k3aCtlSmxLUTRFc296T1pQSkFRQVEzclpzZ0tseTlncHRoRkJG?=
 =?utf-8?B?Yzh4YWdnS2hqRFNMdlpwbWZqZTRHSlU4V1NCWUJ4SnJLck5rRFUzNDhoQzhD?=
 =?utf-8?B?RTA3UmczbmpIOEx0T0tRdVpPVytHVmJ3akJXSG9ZQ0xDNUV6a3ZxekZkTFo5?=
 =?utf-8?B?ZGI3MjZ4TGkyaGFBNmlXNjRIRHNCVWYySWxuMFNSRnhLYWVrN3ZLL2lYUGo5?=
 =?utf-8?B?SGFvKzE5MEZtUmdXNmhqajhUWkViZC9LU2FSUnl4WGNvb0xKbG9TNWdzdDRj?=
 =?utf-8?B?N0ZvWGlMUnRQMGJHMy9PUVA0OFIrTUNwMXBjMTZyUHZYVGR5Wm9SeFFGQkVH?=
 =?utf-8?B?aWlidlhHckp1TjlKZWVzQmdwMzBKVjFXZGxPTkgyZWR4UDMvMTBDeEFld0N2?=
 =?utf-8?B?OHVXdXBOS1BCdXpmaDhJZ3Z4eXlDUDZWK0RvWkdXMThEa0Irajk3UFozYkd5?=
 =?utf-8?B?S2hFaUdjWlFhdXRDYVZNSmxKOHV3K2lnVStxWjBxT3VqdW16S0ZzTDZzbVZp?=
 =?utf-8?B?WlIrM3Vva2J3cU96Y2ZWTXRQcGJneWV5VGIxcVI2UEdPYWZlREFmTGpHUFBH?=
 =?utf-8?B?eTRPTjlyNW10cDh2SjRGa1QxNnRucThxSDBWbjBmSWl4STlHMWFXUkxXQUFS?=
 =?utf-8?B?VDFXTGJRUEtQT0ZmZWpwRm9nNEFaUWJRQWhZRU9wUmlFcVlkWXZuR3N6MVZU?=
 =?utf-8?B?NFlLemp6ZEZWcHp1OW9ZeXBGSnJrTkVsNG94S2s1RE96cjEwNlY5N1dQRjk4?=
 =?utf-8?B?TkJuTkFTYjNHQk1mTThrQXFpSFdIRWFJU3V6RWVLQWRzTXEzUUt6RzI5dkZa?=
 =?utf-8?B?cFowUmlxV1ZIbDhJODdoZXdnNW1OSEx3NlRMUkd3SXNDemZMUklXS2NtaC9u?=
 =?utf-8?B?dFp3YWxwTE8xU1Q3NVlnSmJiODFNZkRZaVRzVmYyUzFFYnMrMm1kTHRjZHBo?=
 =?utf-8?B?dDlPWHRsNWZGWXBpUis4R3l4ait5R2VwWWF1RzVFbzd0N1R6cWxuREZ2YkNr?=
 =?utf-8?B?aXlRbXlZMS9RUkkwdk5kbTEwbDM5UGxmakdHTGVyZlh0UTBzMkVmS0JNMGNl?=
 =?utf-8?B?RTdoRVZUendIdjMvY2FEUVhFNnJ3Umg1Q3BSR3dkanRMZG4wZ0wxMWpRaENV?=
 =?utf-8?B?TDR1UHdWMTZXSlJEZHB2ekJ6SHl4NUx3VThUR3pOVFRiSms4enJMaG9YRGts?=
 =?utf-8?B?aDlFWS91d2JESEJNeUMyc0ZGaFpONXRSWWpSTE9Obkx5NEppQVM1djExb0hv?=
 =?utf-8?B?UkI1SnhEYks2eEdSU1F3clVobEwwcVlCeEM0NytYclVHcUxHK0FwQlltMW1o?=
 =?utf-8?Q?H9a9yYWufOjCWNfOOuvKgzLo+o/q57GjD1W6tPp?=
X-Microsoft-Antispam-Message-Info: ilfk2Ba+evMHE+LQI29mvyWkmATdp/HMnyWV9Cc+gVbSsyrKPTtGfI7O9pXg4ZEZxTVJNbCmD0woiFyF6vfaVrb9e+P6iAXG+aoqyyimR+nbgSHpbuzt24NHTGj27WW9tA1ifDjfGZp+EH54VDEYRjJxKV2dPxd+2tnvm2EtGCRZx5KDNwTFgkAD1176NmBmRtk2XeilQNDwQROvJaPBM55ppc3iNDwZZcj+B48lbCuWNYDg/dcnIGdJ/HWAXRXvnfzn69LdG8MXR83872QDeF7MsHOzGliX1+si8Z86+IgVALKh0CUB+DjCYia6OIFtY+q4MU56NIb472b1KAk9AcMkLbS6u5L2m6nMe9gtYZQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;6:JJmi2qGW7cIEMBHLi7yT3sNYVzjHp2keFBd4g2yfvNR1i8HokS4K3AUZtn1F8a3Ym6GzQx/e+43WmrAKSw+V90qUct1N74SLCb0SMcNGsBj6Ynm9Sf9526Fa3PM1QZG9QbV17TLmpqjblynk/J8knEv/c0xU2gGkWrhp+MhCzBR+052hLvaxJOTOph5ffCGzGfskzHoJTJ8fA8KVnzPw7GW0YNBzamNI474EIXj7IByLV66nIZMYnrrv30z3jBNSaHDf7oqk4aBFHt7nMZ3BXVJtZJzzapm08aXY/JQTgQQrVeCU5ZsrGsR8rXj91arWagDDNBqvqHvTLiBUkPOA3CyBKJFXw0WMO1gHrQHao87xaWvCW1KxL14sVKS41v9y+u4gGa4xei8Azf1jJwwEg2UKLPBdrwaR+OsOfEEJj8JquMavgMY/3S2H0HFeO7iDYfGduJggVygfhLv0OcBqWA==;5:VhiNNa9P4BqvE7EqoeGXbi/V8Lgm08gCo1YT+SZjLdiEzgEz7G4+1b/UQttBMJUvfJ4H58XYui8se+aqgZKh+TwrEIy3vACLfxApHv6f0qyY0qXdLD6V7PXQNeEI4u+SddCur77XyR8m+m1J87LhisxS32zI2aHyPwLmkjL9mkw=;7:1R8JhrDJbGZ9VPHBVPS3qh5XubG1kWUgBu5w+sP8dcBWbg2x/ny6zplX2xePpalLaSMXdcXhQV8K5/hbaERc61Xysr2FQCa/OTNmYrW3eHNT8ikk2SEhzTUzU/5sXP3QerlhagDykUknY7FyGNdlZWAhl0Wp8qYVtoDff0OBNEWQDeLKRas6BEhEBdhfEmlthMjsJL8SmeSJO57+PIHRwv+bv/VrGEVw1lBGThggAmlIqX63KHCRIhscJLNRurwv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 14:40:56.0125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213d2520-c21a-438c-af99-08d607741e42
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to deal with i.MX SoC PWM HW limitation.
When a pad is configured as a PWM output the output level is always 0V
if the PWM block is disabled. This can cause problems when inverted PWM
signal is needed to drive the connected circuit. With inverted output
duty cycle = 0% corresponds to high output level and duty cycle = 100%
corresponds to low output level. This means that whenever the PWM block is
disabled the connected circuit is fed with 100% duty cycle.

This issue has been discussed in various threads about inverted PWM support
implementation. Finally this commit 326ed314fefe ("pwm: imx: Add polarity
inversion support to i.MX's PWMv2") from Lukasz was merged.

Later on Fabio came up with the same problem as I described.
His commit 1f6eefeb7cd4 ("pwm: imx: Let PWM be active during suspend")
solves the problem only in suspend state and not whenever PWM is disabled.

In the discussion Fabio also suggested a pinctrl solution though it was
still only for suspend [1].

I would like to bring attention to that pinctrl solution once again.
The code is basically a copy of the I2C recovery function [2].

The binding is totally optional and current users are not affected.
The idea is to use the "default" pinctrl state to set the pin to a safe
state. That is a GPIO function with pull-up. Then when a PWM signal is
needed on the output, select the "pwm" state.

Using the GPIO function as a default state assures that the pad is in
a safe state all the time from power-up and is switched to PWM only when
it is really needed.

It is also important to first change the muxing and then disable the PWM.
Otherwise you will get unwanted level changes on the output. And vice
versa when PWM output needs to be enabled. Enable PWM first, then change
the muxing.

I would like to know your opinion on this, thanks.

Michal

[1] https://patchwork.ozlabs.org/patch/839834/#1819865
[2] https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-imx.c#L989


Michal Vokáč (2):
  dt-bindings: pwm: imx: Allow switching PWM output between PWM and GPIO
  pmw: imx: Configure output to GPIO in disabled state

 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 ++++++++++++++++++
 drivers/pwm/pwm-imx.c                             | 56 +++++++++++++++++++++++
 2 files changed, 100 insertions(+)

-- 
2.1.4

