Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1DBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013D421BC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LMAi2DCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013D421BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933889AbeGCKDh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:37 -0400
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com ([104.47.33.57]:14464
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933565AbeGCKD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9WBsAJvwf6nVL+R6fnsDUugkVNMOytOg/MtCvOVLCo=;
 b=LMAi2DCqdD98juTzkVvfSaCULs2wMjzbotgBK6itnTFsMwClaOtzOQOAPesvfI8o7hjCIszs9afXTI2tvuo0q9ZgHJ+FVcvp9AZ8AdsWemEfl0bAGNass0toA/av0cVnEoHeIvpY4KsOu4k1Cj3RCLjqujjW/zpZFs3lhRQo7tM=
Received: from BYAPR07CA0043.namprd07.prod.outlook.com (2603:10b6:a03:60::20)
 by BY1PR0701MB1335.namprd07.prod.outlook.com (2a01:111:e400:480f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Tue, 3 Jul
 2018 10:03:25 +0000
Received: from CO1NAM05FT017.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by BYAPR07CA0043.outlook.office365.com
 (2603:10b6:a03:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:25 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT017.mail.protection.outlook.com (10.152.96.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3Lsx023132
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:23 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:37 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:37 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3KAo029467;
        Tue, 3 Jul 2018 11:03:20 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3KpS029466;
        Tue, 3 Jul 2018 11:03:20 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>,
        "Quentin Schulz" <quentin.schulz@free-electrons.com>
Subject: [PATCH 05/12] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Tue, 3 Jul 2018 11:02:16 +0100
Message-ID: <1530612152-27555-6-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(3190300001)(189003)(36092001)(199004)(86362001)(7416002)(356003)(51416003)(7636002)(110136005)(8676002)(16586007)(42186006)(8936002)(2201001)(5660300001)(2616005)(47776003)(76176011)(305945005)(316002)(246002)(50226002)(54906003)(6666003)(4326008)(11346002)(476003)(36756003)(26005)(106466001)(336012)(105596002)(50466002)(48376002)(426003)(478600001)(87636003)(26826003)(186003)(486006)(2906002)(126002)(446003)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1335;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT017;1:9DWPr0lwju9E90F0D4sKUMeyU/DxmlYlL6QZL1Ok8ggnT8bUbtPMQ+fZHTb9a8Az+oLSd7NYWKvL4FzNYkKuh50KjcuuI/TZU/AXfZsPCHuWKFER/Im065Gus4KcAf6b
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf39c5a6-2d0f-4874-83be-08d5e0cc375d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:BY1PR0701MB1335;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;3:KkkVuhICJsMIqw84v/kI7TVodBBwpFIAK/3BVueEQdytQ9ORV6BNtW2E+g8KYh4zdS3VCZvkHswhuZUjn6n0DwoRlp0zuYXsvN4uNDdsuJ6Thi2WzOXDf/Mszhl9O7yZmkCaJkekyS7XJnYU4Td5lYktiNfqcBagmpIXONHirkOu2EU6y1T6GohnUERt0TesUu+lApefpdrGrEZ1zmc+jim57C9CETBTLmXpdKH8yo9ro0LzU6UlZnHpk2kCdXD5wIJFatPsdJlzZsyKv9cKaQjf/ETw5G5UvZZwxSzH9qgA1zrbK8kabHZoYTRcXzA9Lqqc3DBTpwEfyCB8EZaW55+whk3YUF1Xp0fjZvUIU4s=;25:BXjgS7TX7HkTjhZ1Sx3WTVzBy2mzI63XGY0rBM3uVTwwq5iqOYlw85iNjYSLExy6G6Vmnw3M1opGWpJm8hpqEVb+XO1EjAKFsLBoCT4gX0G0UH6MKqwLrJzh77B4L1IltsjFCM5e7UMnWlomJcgdSxQsVF5ap3dUCbGhBMbH7f9V2XG9rd5r1YRwTaoEeCpYbeinH3UiStVjyUYH1knILNo8KakZ2LQQDUC6CYqUE+QuahG5c1aEy3pMZ3GV3AKtMs+aImyiZ5uID6ANfkxj9PPbt3sHZ8bvjk7KrgR7l8m0Z9VO0j/GrLHCtEhDNsHiJMOtPLyhHeHiGYvkScqYAA==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1335:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;31:9Mg+0NurJPE42jbm3BXlOBzTlRnnULl66eaNl1RLqxY2zowL/1fPiBuBu5wzPvnrk/GF3AAByMdfmegZj/l+J2SKkvpvECu4OaNZxU6iUdbU01INcdKV4n8KCx+Jjo5f/Rat0A2en3/CfoCX5xUY09NYYCLNZdr2vXwf810As6iA9hHbxCIamhSXWADKJ+LBoNenOxWGhx/Gh//AbMeWFET/QS1ijEFy8+RJhufNtpw=;20:pixeM3VJ+rGSThttnAVmgWClXfF+HDtYNWV3v+u4w4sVxnW7QnE56YINpm//J8AbxwvtcpG1ABSd2xJXr88stPdkpgSjwbiZbozTLpXyUFJ4Nn3VDVv/bWgMi/GMyN8NejK0UIYYStVQqedZdNGURp+BZy8EiJd+FFZfdo7TfqR/l4/aVTyj5AROHedFhtUN1QxGTgh4T1earDtrlQkzInQER1rxCDCcTBZy+jr1t21iyBAq+2llD9PdAJ01zJH/4GQ+R99jow0JQIISFBolPfxWiknlI7Gko0fnm6dEsoo1N/QZsAOcP0gbE9aCF2M1zL/pzeRXvnNVseKoU07zyZ9jCz/vkL5BBBtSMXFZCKQYiCqqdE6G0eF8i67L+0yfZqac1l/f6bveYQS+WAAtFm7TX0h9OJijYTc0YYFE6wbpnWji2iBPWuCs/PYbT63P4KCQwDTKzp/wMDX/Qpbkuk7iTwTWqY1Lq4C0ci3dORfVZhuFSPLTnI8WeVgvhVz8
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1335D9A864D020718D3FE575CD420@BY1PR0701MB1335.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1335;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1335;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;4:KUXvw7D/CLNs6zQ5uu/sw4x04YpsZjCk0LIMftNfArcATDNSGygkVnF37gI5V6qB1WSJDKP8h7NZDPg57dEuw4e0HACXPrXj+DQW4hZjJeaMqQqaj/swnCCZh4ufVByhFUxcD1k6q5ro6ix357uAacP6jdQNZw1qUYCGXkveQJAlaZ3OlK9QV7RvQwwPNuWvAvNCX7WVu2e43ciFliyyZwMjzL1MomCE+TNCOPS/LXdsLrOz8tAjtH7SPFNmONacCiW30FZDTp/GtNyNVEn6CcdZSnFhSlb++cdADZyJoDDTjEPXkuMHT+7D9W4czgyAiUe/QOWFlkGMaiVXXd5SOpDCdl8UVIo+Kds8uOOA1Ds=
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1335;23:PiobKkygFVS361K1vPxT5VCch1ASYFHZXOVzeXQ?=
 =?us-ascii?Q?+tt1VGfQz3yDQtn4qIZE/lpCbh7b42oMdf0K4yMKTUtmV2cCSVgiG0LxNG/v?=
 =?us-ascii?Q?EgmPTyQXbg6Tfst8y214b9F0Wc6z9Zfys8ybtPMok4cLRYBQZT2p0Gd7KswB?=
 =?us-ascii?Q?cdYwCeq8THzdMwTkXovNkQhKLYqnDobmAe5y7s7NaBwOKx3/DA5mXWLsDiDG?=
 =?us-ascii?Q?xprmmNOIJmH3Tyo3Av1x1IF3YyhigJPyMDVw6OnNbFne3M84vUAFvDI9E9BF?=
 =?us-ascii?Q?Hk2rDHZr+tjLigsNvFfYi6IFCkGPESglTWZ2C8FXdo7vzkLn+8v8XUb9jz43?=
 =?us-ascii?Q?AncWPzbWrQFOAwVURgHsoK+5b3N3bRYGc1+exlFECH4mlMFk39Plj6WiF+qI?=
 =?us-ascii?Q?9vFOv1rOfZg5ocNGrJd8TVdmksWeG+cet4tDGW9XQ6I//2OCMR4dCY6e1qVO?=
 =?us-ascii?Q?0+nSakje7Z3bRffoPIlqXNm8BZpSkBK+5neSKaOpmEKyYK2Ht0RyFvhyHugx?=
 =?us-ascii?Q?hyuFe4yR1D5DDRpAVpynRi1RFlJoL+DImrwMyXXIiRA63xycGff9E7s3FzQH?=
 =?us-ascii?Q?GpI5m19EEE91nIfKNNuch/K9nZ6ye37RJfPQX+LCpeHN9L11DJDIcVhjXk5M?=
 =?us-ascii?Q?ghNUFuXuq9flQMywFM+byHuMDTG7slbXHHFTZ+VUr9oUEKWKNurg4fA/FvFc?=
 =?us-ascii?Q?zXMxK/6bWGrUkz9uwKhgpupU0vXDUmHD7iBLzs9LJl8Rsq4ZHP6MQxWiF1Dj?=
 =?us-ascii?Q?0LrZIkg8RAgFh95p0GysF6PTuaEeja4qoLgve7M71aJp0Eh1+jfyMDpV/GHW?=
 =?us-ascii?Q?5yB6FhyhC2SxD9EjXHJlNz09Lr/y2OrnBbcxNXtmZlfN5PKKt/giscIB1X6k?=
 =?us-ascii?Q?ruzs9CoAjmXR30pz0io+yUT/ge2KDy4wHO4Ojv84ldWh1PMGiai2YSPaHdeA?=
 =?us-ascii?Q?t8mmzK0xImJWe6kkta+KrrrQ1+n350giT26QD1MaehUwkU37ybW6r+bmT1tj?=
 =?us-ascii?Q?dBX4/sWeTkeevYmSsdmUjNmhUngOdi4fjjSyY9tqu8NOn2ousWwSR/N/eJCf?=
 =?us-ascii?Q?dKUjHHEkOULj5Je6xHFo+ThfnGkuUHo/blaDRU+yOWtZgWx518Ogw5agr65c?=
 =?us-ascii?Q?QZV1v/frRPKHYnQWf+HJ5jfyGBXXFRshHYLfkgU0ckfdpOTomGkkEt0JqPds?=
 =?us-ascii?Q?95NIG+BvCHn9HH2E=3D?=
X-Microsoft-Antispam-Message-Info: R8PbX5ckrZ+8J0ng3I0IoCqebdTQsuGZh8zviNmGdnA+iwSPVheTqS3mXA4sZoiNx3jkv6y5k5PNgsAsXZFBBFHGkCDg45uwNnhHa4OBQIVWGHuHWDaSld/8IkMIV/WuWZgNZfQR1RiSatAnVih0QKVqbpn2cDiFRJF4js0tCCLgCk9izCNTAmh8lBqHFebaqNp9kNk51i2/h4VMP6UedeT+GkbyeE71oLqM/q5jaUxd5xq52eHj+DOFs90GtuEvN1aKQ2nUfmz415OAvL0fiw+abibKfSUsXIg+RgPggaj3pZW4Rv1WRJGlNTMjlLJ9Ovig4IBI7vIfBc83HJlQRKMsI7s8tzMtHOZ/1oKd0jXNA2ZHE2ruZpmbqxNWYZaol/kWZ2PCkMrvIEt62f0pSw==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;6:VHkSBOKQy0EMxHI9WnsgYccbgmYvAa2Olba6OoQ5C87urYCq18HFNiZ2DjdTURSXThrTwbG9U5zMCtUgVQQRCgv21LqMcEHCcB+h79oRg0FOU6Lh0iXlpMpkQcvDZ85DcKGVm3nBDpMUzaXZLG5Ip8EA8q2Bvyrg5xPfG75QLjoU4Y2ITmh2a6DMVyb/GTRux3lOc9TERdEEu8xkt/WCaGgLY+P8u0OytiBpLKHKt9t5NJvWnQ/5WILj3jNAXIa5GGy7eWwfqDL6DXBgsFnOpT5qp8svwO7/3kG4YqZy9xbPwuOSGdy1kmkUh6NoYC3e1iE6vt0I58+c9VqUNHKXvIXgMnta7I+Hh6ON4jc/XmUlGLWLOBAu9IoHq/+rfVUlE5S7qFc7PD3HZSyncfrFutJpPUc1NSvpJ5rk+9C/Xzr5gNw7R4DC2YBXY0XWQNaMR/eFMKS3RWV4RlgmwZn3Lg==;5:4EkXdVbVRzVuvD8O0XV3yfYxHqkRV/2nA/Ije4IzY22UJL2ZX1thBevMzDXu0IQ9NyiB19tAelqF7sR+L6/aG+wjC1gGXC/L5n2dLW4PGnKxc49iqVwxp+lYT3USPvpUkCq0RxWl0moAfNzepLDUgttDJ7Wf3CqhPJA3nizhr9M=;24:aa5NFgSRqcKp+5HkXerTjNqqlny/FHVak7VQpqngQYYJRmCCWtJXzgCKxVv2eyroiEodJHS0z+esAuWifmx48++Ddu7U1huNCbWblHGdSq4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;7:NsmgaHVRD0xNYWvJX5DBv2C81aZflXo8cIWmS6rPRlR3+2DYtQXkhSB8TsQ8qH/NRjxp5UTmJT3aZMUSxvu8QarFSPuo4BLuNVof+GQQGOc590dHgUKZenMJqK/i3Eo7cRdSF0S9h4zo3mokQ1t4yWgRXfg0Dg08efjjJwajNUcalG5xqVriEXqOG/i8Tp/faC/M7xP2Jzn6zlAKLEhTuxJTFTvVy2lxb12/xNHZ5vAKjDdkNrwxXHttV6jFqaAe;20:h7XKA1BYWpkI8N9v4Nunf/ZxrNdMksbCFNZPpuud0NCVElMLrJKuM4EAt6le2l4WhFeZ+LVCMbwBXWOogDyKphn+FmncXKk9isbFGuiS69Nqj4ou15JQnCrPidpXHdV+o0KQtY7MhvYtZ/ovbClGucmBVvp0Aqdw463DeFI2nJDAcfkqqcflyQbm4wLBn6iX0Somel0kOohErOx+3J7+3AdbdwFJiyejJZdkj6tA3UMnK2T5FhYv2fyMrnB207eB
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:24.3993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf39c5a6-2d0f-4874-83be-08d5e0cc375d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
"true capabilities" of DPRX device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
might falsely return lower capabilities to "avoid interoperability
issues with some of the existing DP Source devices that malfunction
when they discover the higher capabilities within those three
registers.".

Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved
and read 0 so it's safe to check against it even if DP revision is
<1.4

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 7f5d568..b6a27ab 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved
+	 * and read 0 so it's safe to check against it even if DP revision is
+	 * <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
-- 
1.7.1

