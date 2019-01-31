Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CDAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD5F218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="rJPTS4Ud";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qK/89z7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfAaLx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:53:27 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36588 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728091AbfAaLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:53:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VBqEda024021;
        Thu, 31 Jan 2019 03:53:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=XAjleFgKxFE4kn655EuaS7ySIHzmxzf8vI4Nc8MPjjw=;
 b=rJPTS4UdHxdEhhb7wm31XDklwIxSksNQLJpkIKdsnKodG+IV3KjTABNAN28pLK4YGpZO
 jfxYFETCzys5nQUPbEX6gbTVM47LHAfP9VUumwXq5BbNQzsvQSL7esPqPZT+7Mwx5LRq
 IEKHacJcdJ3QtZ+VuFlC4/7FDNjZ94FlOnOrzm94p3EziPoYnF8wfrHMLjGKb9Ocwx8Z
 uTr5WQG7xJqEvbfdjbOJEy6+pU+kkpGU61RfKfc7SeaRmJlMI7/yh5xlIGJaK0jXze0t
 2NbW3m8wMVDLE5n5JD1dpcF6whdYmjugjZrlCFr8cOR3m0Db/HR8o8yPBqcR7eTMLnJg 8g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2056.outbound.protection.outlook.com [104.47.40.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qbjukkbu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Jan 2019 03:53:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAjleFgKxFE4kn655EuaS7ySIHzmxzf8vI4Nc8MPjjw=;
 b=qK/89z7u3MKeKhTCXQFTRUgtVprghvf6LA4WDmEkSTibLSj9IjLbrqb7EvQhHTKjICGQUDhxn4HG94kSkTjNgaOYyP1i1QG+6q6+OHt7ev5JcoemRqUPdybtcIpVfb93vfyfsjVNjEa6LTpkSJFNUlaToZrQOTgu7zgC7UNf3Os=
Received: from DM5PR07CA0054.namprd07.prod.outlook.com (2603:10b6:4:ad::19) by
 BL0PR07MB3970.namprd07.prod.outlook.com (2603:10b6:207:4a::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 11:53:11 +0000
Received: from BY2NAM05FT064.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by DM5PR07CA0054.outlook.office365.com
 (2603:10b6:4:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Thu, 31 Jan 2019 11:53:10 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT064.mail.protection.outlook.com (10.152.100.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 31 Jan 2019 11:53:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4Sl028139
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 03:53:09 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 31 Jan 2019 12:53:05 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 31 Jan 2019 12:53:05 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr5Ni002312;
        Thu, 31 Jan 2019 11:53:05 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0VBr5Ui002301;
        Thu, 31 Jan 2019 11:53:05 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [PATCH v3 4/6] usb:common Simplify usb_decode_get_set_descriptor function.
Date:   Thu, 31 Jan 2019 11:52:31 +0000
Message-ID: <1548935553-452-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1548935553-452-1-git-send-email-pawell@cadence.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(36092001)(189003)(199004)(8676002)(36756003)(478600001)(8936002)(7636002)(186003)(39060400002)(246002)(50226002)(4326008)(356004)(107886003)(26826003)(305945005)(6666004)(51416003)(476003)(76176011)(6916009)(336012)(7416002)(446003)(42186006)(316002)(11346002)(26005)(426003)(4720700003)(87636003)(2616005)(48376002)(106466001)(47776003)(50466002)(486006)(105596002)(2906002)(2351001)(54906003)(16586007)(126002)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB3970;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT064;1:ch0xevHiqG8s6wZHfM3dAioyzebnb6PEN48ugpeYUmJxvESsE+E1cs2eZHASzc4p7Ip396+LzqnHfL3ifx+zIDZ4f/FbBzZRTPxsX+came7sdqmiFISQhKC9zCDz4CmHo79g49dUOvxqcfx07VhRhYrsBMf59AOrbhXE+31pEqg=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 545ddc6d-4fef-42cb-f40e-08d68772ac3e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:BL0PR07MB3970;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3970;3:y1OgcAn8HQhAAyR8wglSI37B48ugzYy47MMO6xwSp2xtVTb1RbgSwpqI3xatVkEY6aFFOfMT/BQuavTZ7KR42D7JG0eHWvQrf8rOzeVHniWtfnz6GQFIcz3DnCbwN28665zBhyZyuokPg0Eu3p1PL9aAEiKYZSq2jNOuRu9WF8fUx3jZn2453q+Y4Uwr1heEc9HiK3Z8BjlzMMbGTeixagxUHxPRFGMwefk6bzKe/T4uVYK5hhE5kvD0J7lIK21X54P9c7orDW31g6fsoA67nb+HubLKr4ixQjLxvabAKnm4SdlcWkmU72JP57qXiqgL0gK+/7nvJu/PFUpv9VSgeCrm04+IB4Zvi23dXYvN1RkjeW8Z7xeEA38BmRf3GeOE;25:huXliFciA7Xqq9HMhwy9CgIRvbl6Ojw7W5tNQJYTOPTwNBComw8lHL6ruw+T6ZFYA0V9ok0xLQ+BImaPKgIEOWM1MHxPznsIOKPnP2BE70lS7AQBhOcO70sE31fT31izZ2IO4m1LlK2tPED2OSCbOzt28KyHLfVhkr76UWM3JuPmoEGOHLqoX0KRNj4Zm3XvJ7MoEGAJj/wlkoRakcMAb6fK7WO+/h7tCuK+7kdMbnuhY+t4MY+Sa2pwOVIC2+RdPBWi0w51nUab/ku+7zJMRxs0eXbXbi+ndX+xG93ACneiPt/nJKBo0ddyIAnOHBHTuxiSIM4KV1/jD0JvOHeK7A==
X-MS-TrafficTypeDiagnostic: BL0PR07MB3970:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3970;31:mLSlznAlg7+MY+R33HNVGQmJy5pd4FcTScHf7yy3ekLGaJbPoofyjO1QUU1d8q9rNpN91GWms5lMZShe0f6i+KD4s4zW4KmiikqRdbZiSrqYm1+AYhT7v3ZxZyj+nchzCx698LL+3fJfeWw+5uVkXLtrwcOfTpQZ48SRR8laS/iPNVOosU3dUzNQMAvExGAm22pB0yB3G51vHIaPdp6sprmrogYG9TAeAMjvm+C817o=;20:0EUP+wM+NZqI/Ber/WHWO6v3//GWM3N/H5GTAzi5HTCEf7sjAPYOg7JM/imMUZbVGBkcdYzh6UqBC/Tj9tzOz53iSgyryMdebpcei5lgMaj2X8YzsFKbA5lkib8IvvbdYuPr26rG6EYhx9nNXkxatZRI2AQUbWIbw5WPc+8Fw1sooZ87NUihsaOcWX+g5OzvNFNaFT67zJXExH0dZZx/2HJo1ORwAKGTNCtaN25CwpaquyrOA41OgfW8EEtWuFCNeZTr97W5WROUGMAWCmZEIQO1oy6AApOhw2E7UzvMIsDaD47nKPpL8fxdQOJX4LyjxzOb0CVGfOYc3XJsBaAS8IDr5VqN9QfrcYBxfFgYSmpZu4oBMeC9vBBgg0djxYOqicDL0lt8SF4Xt7xoPRsjistwrKsFkams8RcG6SFApMQl5wFfdFeCgX8P0sLB+tBwDt1Y3P6RhmEoiY/NQt60jrXeRKQ9WJLVZq3JK2x0r5lNU6xbqyXJAjjH0zZVooK4
X-Microsoft-Antispam-PRVS: <BL0PR07MB3970AD553913B5B4B4A517F7DD910@BL0PR07MB3970.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3970;4:9DqW5feGQo+sA92tiH+bglDvXb25RNIgXnRnrTg/21I2LGEJ/CVbrzxiOCmZHorOr+/i77ISHjFgQbk3ad7qElBD9lcU+svyCZ0sIKKuh/HCmhIFcEzin3VVlrOOaFMUeonTXe+xTajVn4wqrda1A8NntIkxxAIs6L1/uaZjsKgsfPxWSqk078k1Dt2n90+rKIWQfJs3UOY7O1vIL5GLBP5aZCB0FUaPt+6snHmYaHAFBfZftWtoSn8Oada/T7CR3s+9bER5zNwUlGidEW9Xdizykv8BpirEJ6yfss2Jn4E=
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR07MB3970;23:eMRtqsGRd3A29J37UAC3NkDLCuNctkP3DdremwoZ5?=
 =?us-ascii?Q?75n84TDh/IGcF6edkhhkorNdAouIh9A8hmoI+yPItQXNIybybSjg0MF90SH3?=
 =?us-ascii?Q?yeYa7+URABOLJwTj6KiQEeiCmW6Sic7tJr9M0KtPBMm1fw7wnSfAngqeUHdR?=
 =?us-ascii?Q?rBJ0nRBFYF3d98c+lE4aoCl3Dqi2kxWOpAn5GJ95ZQZlwofs9oot8ulbkUZW?=
 =?us-ascii?Q?m0tOTUN7XDGo80gU+3bfSwdytBc+ISV+tPeCLXq4iw7KwlGQ3nbG1Qv2xSQ9?=
 =?us-ascii?Q?+pDWl6Ih8zCQfyzurO8X6tPMDUA556sXOFkb1qumBguMTYMlAJkicKvxO2Gc?=
 =?us-ascii?Q?n7a2+mX3vwEKKf7aTlMuxXuU+Pj01yd42r4nJ2sYHpFJDnY/7+k2i9EZhNIM?=
 =?us-ascii?Q?YivDV5pij4nXHP+NPqvj0KrFT1NwaTL+zKAKzvkMZZp3xVFq9cs05t3bTPpe?=
 =?us-ascii?Q?oBAXkozeMsDWiRCGdqmOO7u2GngZntEjSk3mKQ6Krl4P85fNQlLzUbQM7J5E?=
 =?us-ascii?Q?xESwAynuFssUgC6kx5fiJSC5xT//323U715gsT57HvdHrzgtIWDeqwFeuQHt?=
 =?us-ascii?Q?e6AVUJA63S0J+VJrYYE5on9/JCHGxwg+ijm5NJLGA5KoXyeCKzPsfNmAU3eY?=
 =?us-ascii?Q?2Okhk0a4E8oZ55hfvmwRMvBmCNKokZ36KBMkjJkZUxEZ5aunqqzn5C4mZIcA?=
 =?us-ascii?Q?sF1/VmMKMj5Nz/hUexb16UUcPFah5vfIBU1g2/68t0EbAex/6a1ps4LUqi/T?=
 =?us-ascii?Q?3sYn86IwUGBtLBcDFK59DyMZwqC8PwdHjIFHsqV+rBA7L8ImlidlnInpbCK0?=
 =?us-ascii?Q?O0Ht+KU7mvDU/5YwCLvb0Z2o3HjlD5TytZ+LkxgrBrssYbuy6xOUPcpd4/+j?=
 =?us-ascii?Q?VE0XIy+7YbFZrWiBEJJM9hE9xs7fztRQMWvm0YOM7PSyJSeoH3mZLntQTCgX?=
 =?us-ascii?Q?w6qedmVnyEcfujFvjWBr85mgPdk/A1FkAcvvFLsi25ZNhFtIc+FRzlWMlAjp?=
 =?us-ascii?Q?U1FEabKJjp30pmy8cBtfqLe3DFdVaB1CbUmGVQpsse+mA/MPvmnEVMo8+qbj?=
 =?us-ascii?Q?TXkOWHVlKh5CtRHPYzPfmN6LVGPD0Ty+PKTHd3jGr8KShVR53VJMvCH+AxeW?=
 =?us-ascii?Q?HdoB5ol61xnPYAuollghr2HjSsBgL+PIvRnj+N3p9gLi/mT6oPikkps1uJ1S?=
 =?us-ascii?Q?Y8xU37uxYWz/LB9yoQjMwMFBKKeuepuZf5KMb9oOH4HSLueOph55PEpYg=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dy/kJ6MK6zT7JvK/vwSHbKF98XM7vhO/TKTFKqHqbDZ527yITL5ZpJAwAc6mU4MDQz1EHrRPP7ocCZHdTrWRRgEH7Txd4PFoR9izyVb+L8+7+Tw1LzSi2OUFc3UXHSD0v+gTkYCIhERfi6fy7P7LFMoxdU14mwvTtfG1YoHKwFSsB/FJuVitrOW7hkG8GZMAbQlBqbNtQc+dYlwWbLJfS9uJgg3FtnguIg+QLQMLThmKVihj6gCD+to0tbc5ptuX/xK3Q2it3Dy/1Jx6ZH6Oi5YbfpaayRym0mhaPykUrmyPLg4b99uEFMbM76TIc/xbzqrI12CUrDPvZnKGrPb06pKOYe5A3N6ZJ7KS+bnuM2lHHFVeOrWa4KOD5FONbAwezktMAXq6RBvWC+UpYzwbWB8Lu67C0HqXO92Rfe/VbS8=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3970;6:wn451fIDvVMrFqV8nR7Sz2tin33kN++vACzPSujZq2YEPke5o8h8kxmCi03w/0gZDSKPPwwUDMiOD//dL1nj8P16rIVgZetRxbpdErKpREwkjsl8MeEoOiO/71HaaNWGp6H0t+dYpphNBGT937fYOrdKGYs+qoT/gVsfJVQvEbZIRm4eoIZi07z+Swnpwuoil6oE52D6t4L1u7CH8nY5IHwUkU1sdxP4TLaPdS4r2X7la6CdAyjXcTYr4G/FXyesvnY93Ivbkf0QwVA1186oHh2/oy/m4b5D8C9PHjGXhdonlO7VsSlq2RhFJY8wM2Do85bZmcDj459cC8tC/m0XizaFZZkQId4r1E6aAVWyziqI7+hEEz5CrDtFDNajdrQ52vFCuxBMfXXh6I4sK7zEe/TMpUxB05PQVxeddykREb04EIA03q3Bc6xlCjKrZANQA9FcQGt7IO/Erl9+6Mz3KQ==;5:cRHyjADpAK/wmIFedw5zg2ScjVpP85D6aOSSnXh0mA5sWYwlKvsGWoNfOUUqL+9krWNKz43Vn3BGtEKTwpX/0GYhma4NzDg+uKAKeZaDTuDEdxRwM7TnoMa41xqqoKKPf01P2Qt0SSA2up81g9vgEU0r3I2ZnbfoOkJKGWyk5DRT0qDovo/4oobJfLX/PZl78Ym2PED5YAc3WX0lH6ULdw==;7:7kkF3KenblAQ9NYKEZuJEtaVg8u2becm2fnPG8gbQYXHFi1fJaQFmbx7S1s/goxWkzHXEPmtMTDX38ymwbNWqgQWxTXjwjKxXUySsPCUHH9t4gcr65Xj2Y/eI9K6iUC2vxE7eC6GS3KuTOlbu0w9pw==
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB3970;20:AMj7W9E6ZBCMaKj2LUF6rDMMHSOcy5rgideusMr4BY4Tgya2vJljH3Uq1dDWxk09qXCUn4mc428ZXVHY0Pauioo3LD1h3pk8l+IPM0gDDF6YZXwEzLyNMmS0HGQr6gZW41/8KqkV+uLBlRQ/a8jbE2mZcY9RRIAFF+ZakvmYtaUcmXdkHyja8GW8mMpvTusS+BANZ8GpUbl+ceetOLDy5o7rYSbnelqaslq5Ds512E4HOz211nAe6syXh/07vuM6
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 11:53:10.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545ddc6d-4fef-42cb-f40e-08d68772ac3e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3970
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=778 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves switch responsible for decoding descriptor type
outside snprintf. It's little improves code readability.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/debug.c | 111 +++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index bdd529a686e4..a2fbcefe1ea0 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -104,62 +104,65 @@ static void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 bRequest,
 					  __u16 wValue, __u16 wIndex,
 					  __u16 wLength, char *str)
 {
+	char *s;
+
+	switch (wValue >> 8) {
+	case USB_DT_DEVICE:
+		s = "Device";
+		break;
+	case USB_DT_CONFIG:
+		s = "Configuration";
+		break;
+	case USB_DT_STRING:
+		s = "String";
+		break;
+	case USB_DT_INTERFACE:
+		s = "Interface";
+		break;
+	case USB_DT_ENDPOINT:
+		s = "Endpoint";
+		break;
+	case USB_DT_DEVICE_QUALIFIER:
+		s = "Device Qualifier";
+		break;
+	case USB_DT_OTHER_SPEED_CONFIG:
+		s = "Other Speed Config";
+		break;
+	case USB_DT_INTERFACE_POWER:
+		s = "Interface Power";
+		break;
+	case USB_DT_OTG:
+		s = "OTG";
+		break;
+	case USB_DT_DEBUG:
+		s = "Debug";
+		break;
+	case USB_DT_INTERFACE_ASSOCIATION:
+		s = "Interface Association";
+		break;
+	case USB_DT_BOS:
+		s = "BOS";
+		break;
+	case USB_DT_DEVICE_CAPABILITY:
+		s = "Device Capability";
+		break;
+	case USB_DT_PIPE_USAGE:
+		s = "Pipe Usage";
+		break;
+	case USB_DT_SS_ENDPOINT_COMP:
+		s = "SS Endpoint Companion";
+		break;
+	case USB_DT_SSP_ISOC_ENDPOINT_COMP:
+		s = "SSP Isochronous Endpoint Companion";
+		break;
+	default:
+		s = "UNKNOWN";
+		break;
+	}
+
 	sprintf(str, "%s %s Descriptor(Index = %d, Length = %d)",
 		bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		({ char *s;
-			switch (wValue >> 8) {
-			case USB_DT_DEVICE:
-				s = "Device";
-				break;
-			case USB_DT_CONFIG:
-				s = "Configuration";
-				break;
-			case USB_DT_STRING:
-				s = "String";
-				break;
-			case USB_DT_INTERFACE:
-				s = "Interface";
-				break;
-			case USB_DT_ENDPOINT:
-				s = "Endpoint";
-				break;
-			case USB_DT_DEVICE_QUALIFIER:
-				s = "Device Qualifier";
-				break;
-			case USB_DT_OTHER_SPEED_CONFIG:
-				s = "Other Speed Config";
-				break;
-			case USB_DT_INTERFACE_POWER:
-				s = "Interface Power";
-				break;
-			case USB_DT_OTG:
-				s = "OTG";
-				break;
-			case USB_DT_DEBUG:
-				s = "Debug";
-				break;
-			case USB_DT_INTERFACE_ASSOCIATION:
-				s = "Interface Association";
-				break;
-			case USB_DT_BOS:
-				s = "BOS";
-				break;
-			case USB_DT_DEVICE_CAPABILITY:
-				s = "Device Capability";
-				break;
-			case USB_DT_PIPE_USAGE:
-				s = "Pipe Usage";
-				break;
-			case USB_DT_SS_ENDPOINT_COMP:
-				s = "SS Endpoint Companion";
-				break;
-			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
-				s = "SSP Isochronous Endpoint Companion";
-				break;
-			default:
-				s = "UNKNOWN";
-				break;
-			} s; }), wValue & 0xff, wLength);
+		s, wValue & 0xff, wLength);
 }
 
 static void usb_decode_get_configuration(__u16 wLength, char *str)
-- 
2.17.1

