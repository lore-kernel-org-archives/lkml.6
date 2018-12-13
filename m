Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F6BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B84D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ELb/NP8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B84D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeLMPMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:12:51 -0500
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:39568
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbeLMPMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfCbXgW/J1Yc8hsgmLbKeXPZ/auDHuECMe+/iuUkGBg=;
 b=ELb/NP8UZjpvPXoGyMmomcx97p2RsclmuqCtoKsLhozjkxUsR+P/LTaTxJ30WtYV3vY10n7YuBX+s+mU8Ci7/1jwJIftg/cQbo/l8NTzPHpd6CuL192CGs81vDrvcdxbZpVNy+JCUlVeOItQnMyBKsFm/4Nwg9khKNX23Fk8C/M=
Received: from BN6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:404:5f::11)
 by MWHPR0201MB3514.namprd02.prod.outlook.com (2603:10b6:301:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.18; Thu, 13 Dec
 2018 15:12:46 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN6PR02CA0025.outlook.office365.com
 (2603:10b6:404:5f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.18 via Frontend
 Transport; Thu, 13 Dec 2018 15:12:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 15:12:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gXSfI-0005TK-FN; Thu, 13 Dec 2018 07:12:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gXSfD-0004ZV-Bu; Thu, 13 Dec 2018 07:12:35 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBDFCWnr004585;
        Thu, 13 Dec 2018 07:12:32 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gXSfA-0004ZE-BG; Thu, 13 Dec 2018 07:12:32 -0800
Subject: Re: [LINUX PATCH v13 0/2] Add arm pl353 smc memory and nand driver
 for xilinx zynq soc
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        <mmayer@broadcom.com>, <f.fainelli@gmail.com>,
        <ladis@linux-mips.org>, <treding@nvidia.com>, <digetx@gmail.com>,
        <d-gerlach@ti.com>
CC:     <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh12@gmail.com>
References: <1544100454-6357-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <14275918-b8f0-fb2a-1678-562100a30591@xilinx.com>
Date:   Thu, 13 Dec 2018 16:12:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544100454-6357-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(189003)(199004)(31686004)(8936002)(305945005)(2616005)(58126008)(76176011)(81166006)(106002)(316002)(39060400002)(54906003)(6246003)(63266004)(110136005)(36386004)(64126003)(230700001)(65826007)(2906002)(50466002)(966005)(36756003)(81156014)(478600001)(106466001)(486006)(47776003)(65806001)(426003)(6666004)(356004)(2201001)(65956001)(8676002)(6306002)(5660300001)(186003)(44832011)(11346002)(9786002)(77096007)(26005)(4326008)(229853002)(31696002)(23676004)(2486003)(336012)(126002)(446003)(476003)(217873002)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:Q6F+UGstedYLVac92JLp2DXbYavYTDAmeiBfRD1v5FH+EzCaqSPTv7LRJMYGGuHvOHSZO5qT0K+XVsT2dRrU77VRb/dKlSmi8N03nTQDtRZoGCfCq+d5HNMA65LnzckH
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b4ca7b6-c8de-41ba-7790-08d6610d6f26
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:RuDzjny/Vx/xWWH153iQPq59hYyJ2znUPZpRamdw+3cQdoUD9e0Z+0uXkudxRhW8ulx+RADm7c7LRparfz6dDGiSrFyahn90kgAKhze3Pbnk/82PKf/fPjZqMClnPKohDmlwVFTRoP0tJ6jmgHkdJWxjh8GCvWHN5MNHShkstVO+HQRTEisineNmyTt/g03xgp2ta0OuJabI0SW7zVRHvF2Qhm4hoQHkFv6RbxYyUwDrMe6HT6uJ4zb1R4az1qIv5zUsNNsavg3T+kHRqejJHyHD2mz3K3NERFUVGY7vCrNFLgI74PmJEigzC0AqQOIw0qPza+9AEP/uZ9q6g2YLjFHJxiUO1Zpr9dXeYEm31Jk=;25:4loITrdwLoa/tvocjI1e2wVkz+DPmONUS/m10RCaloaXRHzaLuD85wakvXHQYC4GeYDoYoxfX+ssOdxRYP4n4g7XCU3wiFZRrXk7XntR9TzqtKyj7MREdqERLPIM/6kMmqBM506ERvouydEv/mIRoXkSX+yH8eafKiBmvFUDqJE0WuaG9BEz+TaJ6sIPqrIbdTRpv82NDTEbPU2mCqcUXU/Nye7Y9bV5R7PTLM9uyJK2aVUeLOPxtAPyTT22nmvpI2ATN4ZTZ/eXs2frnaXkMzXR0im0lupes0K38izz4MZR1sDIG7+1UeYtN9jg0B1R5boBcCZMhmz056ii6gVoww==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:n+iU1nu0RotuvJlihe5BKgBSKBEGFWoqpwQu/IY22vFpfbTNO8w9GFgbNxsd/kYHrSGVcRmKaABZh4dpwzSfGL3yyHGNjsd+3XL21K8XeSJWXv4/qOkmvvM8SlMUweXe5PWR6OqmXEAeEfxXlVol6IsgblLvTcEV/aNFKi6ZkZwvqTR++b8jGTjyYni+m3se5ssDqzOVWChvRv/2JrHmmTkhF35QBJDYOqHPbH+Qe0I=;20:URz8JwTS6FafKBa1/sp8rW79L0cM1hnFuD9PvIo5ZpJtjLo6M4TU+GH3YDCLrh1OM70LcKWRM0NhTytIWUOlUcBbFEi/rQr8NNhhvQT91R/XFVUoPTLINEVZB2b27n7ZUz+J/QIaksJprBv2D7aeTVZ/zBlr9hQpLvMvwkdUFwsDlxw3W5sLbRIjCp9TMSOrW4gslfR20Y3C7XJUyj/AMNzg9v9bB73anYATz1FcAroV2tD91uJEXVe/tsA1ORUzcXoN2RTWSAHI1qjot55I4KSiphh7e7V988Z4xU5AiBAhcJ8Aqo/DMruicZpzDetYCn+ZEdn+2mguOmOVNj3n64hKHcNtfO88RMa2PczBEdGL1bwLJkccaIxP+3z++Y4Yjp5DO9L0deCmUSXmPlBQwIlme1U9wlmAie94g76YagbfO6BkvinSNBcvtBKV01rtn1ZqOXsdHW1xBFBgQqLwHb0AkHmPD3CyAvNgDt/aUltk3hLac8WJYXS3m+S28Uev
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35144B405296487C5AB69E0DC6A00@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231475)(944501520)(4982022)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:mYwJMWLp26mP4EXgFV17uWZpzOyATZ3PMagWs2sKlGnEj/5oegpiuprus//hrEQLTSKBdalGzTWiRLe8Bpm4Z+i3RBhLwNqw19ptiR9k9OT0jHYo+tprDD+HWj+khv4g3mEoRGXSGnx+lf9OkSPBOzsgY+YFbX/zA+pj/kQ65rCPuswVmKm/1JK/3MDY++AsXkVtoMtyhucw7ci4N11T/NhM8YYqt0L11AEYolESm/1IvfHqMIO8UButjFkuOEWQ6M5kkNw4riTByEIU0xvJ9g==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyMDFNQjM1MTQ7MjM6ZmI0cE0rSkkvOU44MXlVcVlkOHd3eEx0?=
 =?utf-8?B?eHI0RENGd3pFaWgyZ2xscHBmNE5JMHVwZEFoZjJGVEFoODNlcmlJYUFEcG9o?=
 =?utf-8?B?WWFHUEJwT2xDYnBweEIvYXpiMjJSVHkzbkhxREVINDlYSm5ZM1ZEV1c3UWZN?=
 =?utf-8?B?dXgyZlkrY3FmSGpSeVpSZFgyeCtkalh2M29IUWZUTTRTS0szZEs2MW0rdzI3?=
 =?utf-8?B?bmJoNkxXQmk5T3hhUGhGTDJMTUdRZFh5TzZma0RreXZTUDBUWVk1Qk5oRWNO?=
 =?utf-8?B?ZmlvSFVVR0RydmRsRHJmbVMrdG5XVzZtN0FDVnJldGRSRURxZk4zclNBdnNq?=
 =?utf-8?B?bmdYY2lNbGRoSW02K2JydTdoeVlvNExrU0VNWjc3dTljbExmR3ZCb1RwY1Yw?=
 =?utf-8?B?VFdCRmpteVlNQWxsaXEwdGRzNkkyUE9IYll3YVYreWsvRUVhQkxBK2RGcTRy?=
 =?utf-8?B?SjQyOWtnMHYreWViUGlvMStIaEFpMzZ2TmZpaE9ldnVvR1NKYjBwK25HNWVv?=
 =?utf-8?B?YmdobGFYNEpFbHNsOHV5ejgwTVdZaXZMYnV1TC9vQ244ZUU3NFZ5c3Y3R2lu?=
 =?utf-8?B?VjJxak44MXQxU3VSUTBTTDA0Mjg3NFMySjBhTTc1Q1VZbGFpbWxhK2tjc0Z3?=
 =?utf-8?B?YzdsVC82eW9nQ1Q4NjZXMzlIcUt3TUUyYnBOZzZYdTNUOWZrclRUUTViakxO?=
 =?utf-8?B?WXlJN2NKUFRFbE5pL0Zoc3dRSWc5VVp5NFdGZ1V3M2lkcVNsbDRoUHRFL0pp?=
 =?utf-8?B?VHplRXVXeUdHNVhQb0crSGM0bE1pM0tNdzJCM2Z1RmN0TTNYUkJUNDdFRlE4?=
 =?utf-8?B?YWlHTUZLQ3VYSzdJRlUzR3BjUTRwSGJkZ1Y5QUdOOGMvZVFWczgxakxaT1Yy?=
 =?utf-8?B?dHcrM0xqUUFINFlnTWExRVpyZUxGQXJweU85OTFKYm9hNlJ3MVBDTTRISENL?=
 =?utf-8?B?Z0RYRXlQSEtJditibkExOEc2T2lETFJnSnVCZEhjdWE4MWFpOC9nb0lFQi9K?=
 =?utf-8?B?ODBtWjBJbVZNSU1ha01OdWlJL0I0cjFaM2t6bFQ1R1ovcVFVejhwdkJRd1o5?=
 =?utf-8?B?QWM1c09qN3VxcG1CdGx3TGJPS2YwOUpxaCs0dEhQMG5NU0tIbEVEaVE0Ri9s?=
 =?utf-8?B?ZFdyYjhyTENXZWg5S0UwbUpsM3RUNzIyVFY3K25aalZxUWdsK0JQUHhoOHBN?=
 =?utf-8?B?NHMyaUNOWFJwZ2pzeU9qWFNybXU2R0pYZ25yZEliTTlDVW95eHpScU1EbFhz?=
 =?utf-8?B?KzhYTkVXWHV4YktLSU9RMTAxcnNITFVRbXlmcHlSRkJ2c3BzM0VvME5hNEIv?=
 =?utf-8?B?dHh5TjJFOUVtU2dtMzgyYno1SzRXK2hKVVlZUFVMeitYdUhnMXhpMHF6VTFz?=
 =?utf-8?B?MTdjdXNHbTlpdkFud3BBVjRwSWkwd3YzY1JLN2dMaktNb1RpSlpCRVBHSmF2?=
 =?utf-8?B?RnViam1IZndNOFMrRjkzcjRWMU9zNFpWbk1EWG5qNlEvR0FmOThOR3RBUWlv?=
 =?utf-8?B?SlRvek04aWRaMXJ2bldBSUJlVThlV1p6Mk1ZN3lNZ2hnbVpKUDdhSkNxZUxh?=
 =?utf-8?B?cUJMQ1U2UzNKaG4vMWt4STQ4QjRldFlJTE9xYkRFT0libGlSV21qWDZJakFa?=
 =?utf-8?B?SXZRaXdPT0dEUUt4QzRSQVVmRXJScDdZQWdMWVlXSmRNT0pYaHhteDkxR0Fy?=
 =?utf-8?B?UDhBejRGZ2IrMlpQQ2l5R2QweGZWNkJSR09GV2ZJS1p4cXBkSFBOQlZKZG1Q?=
 =?utf-8?B?M2lucVc5T1NSdDBKMDR1eHRiZ1NSeUpnOUxneEhCTnFEamczTlo0aWszcFha?=
 =?utf-8?B?QVhzd3plNUQxeUxHQWNVaFFpcGhRdWw5VVFNY0NiR0pBY0JNUT09?=
X-Microsoft-Antispam-Message-Info: xJD4QD9/HLv+8oe3uZmpPHmyoj2NmQDDaDHt//51jZruJluDgzW5/QMXm8pT81ZWyVP+mdAV5OQdX4WuIDo0df4XqFaVGbAsK8CJPW5bBo8NA+4a9du6RnypRaxK09lqxNl9q+CJhAH0T+R91xl1CNTGHqBXc5kV2vVfZc/ZN/TtLKq0ixuUTYKBDiEmUFR72nw8+AOphpBBxH73AgWDXupCJrU3gt7TX+Fy1QuzvttPh8x0drV1vUa104pCHnUOVZxCyH/8hoq58D8yOlqWBwL7KZKROpmx8362sDHaBwpnEkemPAnbiOhB2GDH3CuC
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:lM/xr5xc0J4L126fG0/asnAMzGgFI+CSvIpRUSILgo2U5ZhBDRokem3tVca/P27sTRdSCeYXYjSpFwJda+l6by3x0q5fjy1w9tCZ/3DZbwYB1dUlhMSujj/C+DoI4A8ZSTNs7m4xGRdhVKODgZ5ZK9WDtr8y67yod1rlhKws56zB3vX7ZkGYPtEFhVDhdgTWJ3y/P5ZlvOQUeszZrLdnRmtOz24DgljpKqOT1DWKf4pV7B/MMa3NBhJHN9Xkj2N9krrJM23aF2RRJumDyTJ44Js4j/pwW0XwRDPlJMnnpwgJU4xjm8atw8l2G7vdJz8sAmgZQ1JuGAzU1zb8KYQGel29YSZUj/ieW614Tibq5yOI7ROteUGzs+wJlkPNtcJt0b/CTA7fR+zR6mnUx+5CIv3sPAnOknAyck7ehi2Y3gaFowRPvDKI7clxiHVKNCFtZZG5fwhqJCswpBqOKd22qQ==;5:AoRlPMVCTDPzYSmjbApGSiDgpa6Mdf9CsmOLssH3vRBWx7uiVaijgnEKo66RZ6IxMhfvk/y5bfKuFUpIoTOIl7s2M+Vva25pMYIYwV4lvdXUyz6f7qcvgEmRebd3mWyCtFw++IsPTSmFSI7OcPHGGEHQqCRccvcnllbJv+UKM88=;7:0A/skV4+Phdb+timALx/Vm1PNHNgwC5RYUoDiYIV5AqPZQ+yOqF1DOestGy2CXbc/N8OgN+ED/zlI24kr4RqEfIJBaovrNkxfBwkdyAr/GzEbQF16fueiOQha28iFUJXAT5Q/6UKl7WVvOz+DMq3Vw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 15:12:41.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ca7b6-c8de-41ba-7790-08d6610d6f26
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 12. 18 13:47, Naga Sureshkumar Relli wrote:
> The following patches add arm pl353 static memory controller driver and NAND
> driver for Xilinx Zynq SoC. The arm pl353 smc supports two interfaces
> i.e nand and NOR/SRAM memory interfaces. The current implementation supports
> only a single SMC instance and nand specific configuration.
> 
> Xilinx Zynq TRM link:
> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
> 
> ARM pl353 smc TRM link:
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf
> 
> Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.
> This latest series make use of ->exec_op().
> 
> Naga Sureshkumar Relli (2):
>   dt-bindings: memory: Add pl353 smc controller devicetree binding
>     information
>   memory: pl353: Add driver for arm pl353 static memory controller
> 
>  .../bindings/memory-controllers/pl353-smc.txt      |  47 +++
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   1 +
>  drivers/memory/pl353-smc.c                         | 464 +++++++++++++++++++++
>  include/linux/pl353-smc.h                          |  30 ++
>  5 files changed, 551 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
>  create mode 100644 drivers/memory/pl353-smc.c
>  create mode 100644 include/linux/pl353-smc.h
> 

Applied both to zynq/soc branch.

Thanks,
Michal
