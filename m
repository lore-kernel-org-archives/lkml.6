Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3728CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB6B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BOwjA3Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB6B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbeGSSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:46 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:19918
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731832AbeGSSnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge0h0RS+dyjYIxtn4shx0u4AjAsHuEDF0jqHDUDq2Yk=;
 b=BOwjA3NtS3Y67RbX3ggSuUfbschJ0OJH5y1ly3n72Hos94tzYZgtrGG67Dn3T/9i/HMckGi0nlFdOiR4iYzm6j+P1nJ6B3KvQwhcPs+pyH3J+76/E7+G0jPzul84GF6KiGFCE1rTQRJaLAjimy946DvS2AfRJZ7++FZNhoUmbFk=
Received: from DM6PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:94::37) by
 SN6PR07MB4720.namprd07.prod.outlook.com (2603:10b6:805:3b::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Thu, 19 Jul 2018 17:59:18 +0000
Received: from DM3NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by DM6PR07CA0024.outlook.office365.com
 (2603:10b6:5:94::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.21 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:18 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT025.mail.protection.outlook.com (10.152.98.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:17 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS0019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:17 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:27 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:27 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxBMe005750;
        Thu, 19 Jul 2018 18:59:11 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxBAf005740;
        Thu, 19 Jul 2018 18:59:11 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 10/31] usb: usbssp: added usbssp_trb_in_td function.
Date:   Thu, 19 Jul 2018 18:57:43 +0100
Message-ID: <1532023084-28083-11-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(189003)(199004)(36092001)(336012)(54906003)(26005)(4326008)(186003)(36756003)(316002)(51416003)(50226002)(109986005)(107886003)(76176011)(8936002)(42186006)(16586007)(426003)(1671002)(305945005)(87636003)(5660300001)(7636002)(4720700003)(246002)(126002)(11346002)(446003)(106466001)(48376002)(6666003)(2906002)(26826003)(356003)(8676002)(478600001)(486006)(47776003)(476003)(50466002)(2616005)(105596002)(575784001)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4720;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT025;1:R0kMWDPXhm/dD1/lx+IjEAsk5LNK8h+FzawU0jN1fftsos/u42A78z7pkvjSb8V5o/YbSzTmsN+Gli51mJxzlwJpAu/wGJdMUEayvI2CLidXI2ud+zA2lXtGfuq+cxZK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85734a05-2f45-4bae-c07d-08d5eda158ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;3:lZPbwECOu2cHm8AoNXivxnk9739UAZIGGqNlHzat55KbDp7vpz66aow7EynKXmZ09PRcCsbPOFoUzysxVLJsxBZBMx0zlrQanqX04QfeTgMFwkUMrO0+LCogWjATQFXRoOB88ItiQ3PnyKvYMahgiMBRC8FP6TVEHQLhh5wgt//Zn2spsD0VgwMT3hP9wtlZOSXOi9iYqZf7lw7d6vGXE6yIFU+5cuTokQ0jyYYyhYDdLaKn2aA+2AE0pSkVPERE1+7O11I8Aj8uMqmjpwrzrCcgV/kB/tb95/AZ8MVjSxv3/FlmLw1JjKvtDzo4f+Bhypr/3vZchCP6dfPN9rciTSJgwhfwZJR38kiwp7mCcGk=;25:ci8X10W37H0qTce0O0CNcq4qda5mk+HIyTw3TumtvI1GtFRHBVTVSA0tl2CXJMR7WiLn5Y0jfxsibNgfuFPCk9+TvvYhmKou3vCyrarKyYrtmddR26RDt84ZPmpboDZd408WZynXvNccF1Ar9mfWnMhL4TIl/5Is4vj/UlnWku5RMEw2JFO7hYfY+N0OpqLy+qH1kyZFQzPHtHsIAWGFDZv+osNny3T/BSSqvZwVeXwlwbVtvhDaRHtSDyhD+K2pt2BRNSNKTNNYwqod7GB04XHucfhBbiubNWGo8umFPq+WZLX9r8YWwFgjM0Iub1Na+Pq8BwMHqZ64tQho1Wh2ow==
X-MS-TrafficTypeDiagnostic: SN6PR07MB4720:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;31:qtCNjAI8Hw1B2cc6P1An2iF4sliiEVJaZbqOCZr/wVFPKsdrkaDqMV04uXVCuo1FXnUlrzRg/dcGQZoq2obHPGcy5iJsQhdo+ckJR+q2HgsXlECY8AGxGUbLRU4wIePFtUhfrIUGuGXmS9qgOfnm7TSzEVc6AzvjTXNrF02RP/nApPTAOymtmMz7SrAd1B9WIZ0QfU3cm1t+OgJ+ZhL7xuBE0anX5lluarTBBxJtUOQ=;20:5a158NgSdWA8P4WZDhU6y5kdOp07EH4Zebn6XdLO9ex6UnJf6ewIrgbGVADO1vMEbcgKJtXMywY34xbjx4DJKpfECSQpIYfHgZcz+QKtm+XRzTWfVDJF8Y4IvH0v3/7uGTJlp0UavD6ooBCZnmu2zPPYOjYvozoxRD5zUpSp+162z/2j+5PZaW2fG9UyoWd8gIP4pyctCavmhR+co4eUZQeZDo5do1AkMDTuYO918VSFOl+nfwslTNRc1SPYfsxdONtPmu7dzIphqcxzqZ+ENrwCc+9MEORC+eHJucsSwmTv6uCyL4YcxuxC5kT8h/YRy3s7o5SCIfb5TbfHsV2h2cpe2MCPTofDVqandf3zf9DZEjzC+0Tv89fC3kc9tRI0wd8zgkPhkjlRahGkg+dpLJ4vj7MuqWO9fpBAiocAZT/vT2eSzGjGKImHOYbt/ssxLBjGkRN9BpkZLbBGCDpJDxmPmaiO6O4qAgtliYqO3vhDlL5FezBqZRakAGHRfV5h
X-Microsoft-Antispam-PRVS: <SN6PR07MB472077D060B90404AE5993C8DD520@SN6PR07MB4720.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4720;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;4:YcXVXsCT2y1jZ2pHq9h/4om8cfFeTvGcHVwq30tUtgAbxOelhLblaXF9QMsh5mKLtMem3m08N0dr65tCEESy/xJN0AzdQR5fiHyztJAsRwkD9R33mc/32NIqh4FwCxgzI+QhGFwXr/NX3TKIp+9ZqKSsBz5ud5oRPM/bgO7CnxCMym0hWG+voNAmNISXsnE9QzjeS5k1+xodVkb7qGKTmLRx0gOYHm6N3shnSiAnEjqWVQGdWRCjuCAIsUZVNgu+PcQJzmoUrYT4rbb2VeIifK9peNFDHDF8JvAqKDwEzJu9dEY34hcaems4Ro+sI7tg
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4720;23:OEbDD7Eu1HvTp8F/0Uv+9r5uxL5LsbtnEEZ33DiLS?=
 =?us-ascii?Q?WVvWwDK1xYLsZaM1ILmsWNj3rygZgZD5+3lxrqbvEhFRCPgEacEaXA/5pJ1L?=
 =?us-ascii?Q?xK93sqP199MCGEUQ7JtF+2V5OVWNW02brGx7Bv6Wbob0tWBsmCj5gPa6MNFs?=
 =?us-ascii?Q?msy75jGExIriXPpUTVP2VoWXUpGu82xxOzwCjJD+Lmrx9tNEi+fCkHPUEyu+?=
 =?us-ascii?Q?/xisrcJXmw9yf40MEnRWzO2nYKZ0Gp1GlDjhuF8j4fIK7+qxWOc59UqafV7H?=
 =?us-ascii?Q?8OI/V3b88K2nukkBo7BmGlhiYOWCHrcEsATN3y4nyP79AjAQEYI44mrKgKUp?=
 =?us-ascii?Q?VUiqfHqYfSYI1BLWmwx1DDtvAnJoN+zGyq0Gc0s8BdvYJf4bqXKvLBwKG/yc?=
 =?us-ascii?Q?L+oOPX7t5G+62Xahpv95W6tEsxiBjtUTdrBLUfSsZ//zZb+gUi43ElPeYNXk?=
 =?us-ascii?Q?BG76qDvlkY72/A7n2/EB+p/8Smln1oATdFrs1W8GtRoK+TBeMhkTtCerjWNN?=
 =?us-ascii?Q?EErRs3/6QKbk94jWueDhO7HymLQtmVNHggvmjW6kN1u1KJ68y4K3ptzLfPYt?=
 =?us-ascii?Q?UBY0RF/M3X4NFIZgcGMKSdFDlxF5ZfuDmHef0DeBq6f1DiP8/GW9tG95H3Q6?=
 =?us-ascii?Q?SST8onJAdRJ36csG3FPfy3xAz5D7hgG6XTh3rsGzBta+wABOaOXyzK+p8cuj?=
 =?us-ascii?Q?A/Ka8QnTARcbULmIyS35hVG3CRq+uW6gvKv0vnKxTDAfShvK48IW+HQYCIAo?=
 =?us-ascii?Q?XeC69LoM+8OVg4liwJwuo8hokXih3zLX9zChHtyQgz+CKgnftnSboVBziNmG?=
 =?us-ascii?Q?vv13WD42XsK+vgBJ5Rs/OHfI2d+kaq6q/jxv5uq1B0lU75Ii+iPj6dlmzCYN?=
 =?us-ascii?Q?WspoKM6DTrGzXt0V243n9mOJe0Plm8v1ilejrpVmrlVjPOEGMIGxW8u/ZgM/?=
 =?us-ascii?Q?I+AhsuUd6rs/gJoERxoKPkW+DL+Sq3stjoivg1NgBqYxyIrDwPt/9nvYDCw6?=
 =?us-ascii?Q?ATPsqW25Pup2UYQcAiODb8YMUwM7YunyeRkz5VHs345xmJokpO9CGI/cpWEw?=
 =?us-ascii?Q?t7PXSR4TxgE2JhVlq0xWil6r5BDoCivETZVFIBgYinhghtRqeKC67PdWNWBT?=
 =?us-ascii?Q?1Jm6vQ6HMef12lfp2BBJ3/KcLBeSqTAUKM/fMAtimrvbRB2fkfyGw=3D=3D?=
X-Microsoft-Antispam-Message-Info: zIizIUKl+NFMd/VBm8+8GwWwGiQmP1BTzOAOdlmMfp/NYiiS/TN3bcj8i5fFnpvFjcc2HMz+ssiQFi4zTE8n6HCm2d5OH3SR/ihrxWHPBqZUr6uECK/yM7N5DMRqFoxMUJy0u2QFfjGRR1k3Ey4r0CFmluyS+yoAAuVtp8i8wHCgqEoa6iWaINhy/dGnrS/H3ay9gL1Zg+2IY0fOrL2RWPfcF699xxxB3TuAeCN1vSttoAV+3kOX+u0eDYl10PGFnex0SeuFrg1fjlAWZvv+yKKHmc4rAInRGQOFZ1GnGQenu2w6EFlmtF11RB/tUKB21C7MC578BZ5T56f2h9P2HGwe+2GTF/ujv8MTaQxoZjnHNS8Ute6Osev0WH15qFn5NcydziAktmka7f92nNUawA==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;6:DQfHVc2oSW41CblbAfn3rB8a02UrWjlZ4o2JJGWTq5SLVj2IKXsFxtG25/SpUrpIQNcYjpjkKqIzQZJqxSy6ERMyOsX98nhqtckdU4a6eGc+iM84RedrlMscCy+6vLv7tLq3psd9bDn60gQpLfMnqFoZpM5OFIrbWXrG0+4GavCaH+n731sByMpLWyVL/5cUaL1QwCpSGRrVbraRuMdCouj6be+12Gtmn3kTgaOJmt2RFuoEAtMnEnFS1wKq1AZcAQ58TWNswJahF5wDRZes0G87aEIVIW3oK7vqGHYmO0+amHfDPNt3hP1wgwVX2YEO6zfg5SGdoQyGO1LAlhDbigIwbw7NxDZA0LrTlNMPBBHgczUMZgheaafFyuZQTrsv/eAO/0amzpc599OC7UmhM249ywVhU0OhXfk6fBs2vVyGm9qJI+jZ6zCpM6TQA1q6+rbYVfWhC02oW3KlIa6VIQ==;5:1aAvjil3hiHhVnQHGL61J6zZ4R/XHv9NU+/WcL0l8/2GPQOrcPxMfX9zaVswA5vP9dCNTXOUgfA1J4JmUAJgwIF/2oBzgcnQfstVUmFIbCx10oOwC0/MUjhCGY8itUZoeL+TwKNOyKoPOAXl1cpUhyfuYnEK9jxrAGLDvgoPwK4=;24:wrzrJ3SzJWDdasGgc4XfYWgUM7WmfpsBQyiJL13TNCizv8zbmjvD+Sk1JRpnlDlwe7yJp2LhZ5XfnfaUww8CKqAtff6c2QkJD14grR8XF1A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;7:/7k+CbX4fpJ6Nkgrw1pQ8xcBHEtjAQ/BBbK5y/pgOnyBJHYNK3PMpPasictDwGTeJY6iImBMDC7Tsqe/k74KH5j5sOolbL8chsQB5wj35FP6LfaQZGiLNEVvVIohPYbG/mm2m2ZA0TMZz6IIasUqC2D7oAgMXrua3J5ByaQYroUz7tbmFU1srx+27g/LWQHhO2oo0yJreq74mr9XE3R3tEBNQ97h6AArYGOOaaagOHwiGGEacWTYQJzE1moAlaft;20:ToiyZ0I7S2r9NxoQdHsDYPa0g/rqvlwhbzu4HI01fhbqLRvqcfdas1zJ3A0GyzzhEDLmFS5nAjo9otnp3ny5NBULVel/TCW7d7/LYx5jyAgZDqk/pY2/j2uAGrMqtRthz1DQyEn6K7OgW/WJNfNtkKQK/GLYnk4ORfK6AG7Zo0MkWyr+3Zm+yF5VZf6iHM5NoqJlCQ6HAACzdV3sWp5rd3F7jXSgEaC3pblJ67Z5WKw9AZDhwXUjHNPyC43rEYL8
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:17.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85734a05-2f45-4bae-c07d-08d5eda158ed
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4720
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usbssp_trb_in_td function. This function checks if given
TRB object belongs to TD.

Patch also add procedure for testing this function and some testing
cases.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  | 168 +++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget-ring.c |  76 ++++++++++++++
 drivers/usb/usbssp/gadget.h      |   5 +
 3 files changed, 249 insertions(+)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index ecb6e1bbd212..fef83b6b6cf0 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -765,6 +765,170 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
 	usbssp_data->page_shift = 0;
 }
 
+static int usbssp_test_trb_in_td(struct usbssp_udc *usbssp_data,
+				 struct usbssp_segment *input_seg,
+				 union usbssp_trb *start_trb,
+				 union usbssp_trb *end_trb,
+				 dma_addr_t input_dma,
+				 struct usbssp_segment *result_seg,
+				 char *test_name, int test_number)
+{
+	unsigned long long start_dma;
+	unsigned long long end_dma;
+	struct usbssp_segment *seg;
+
+	start_dma = usbssp_trb_virt_to_dma(input_seg, start_trb);
+	end_dma = usbssp_trb_virt_to_dma(input_seg, end_trb);
+
+	seg = usbssp_trb_in_td(usbssp_data, input_seg, start_trb,
+			end_trb, input_dma, false);
+
+	if (seg != result_seg) {
+		dev_warn(usbssp_data->dev, "WARN: %s TRB math test %d failed!\n",
+				test_name, test_number);
+		dev_warn(usbssp_data->dev, "Tested TRB math w/ seg %p and "
+				"input DMA 0x%llx\n",
+				input_seg,
+				(unsigned long long) input_dma);
+		dev_warn(usbssp_data->dev, "starting TRB %p (0x%llx DMA), "
+				"ending TRB %p (0x%llx DMA)\n",
+				start_trb, start_dma,
+				end_trb, end_dma);
+		dev_warn(usbssp_data->dev, "Expected seg %p, got seg %p\n",
+				result_seg, seg);
+
+		usbssp_trb_in_td(usbssp_data, input_seg, start_trb,
+			end_trb, input_dma, true);
+		return -1;
+	}
+	return 0;
+}
+
+/* TRB math checks for usbssp_trb_in_td(), using the command and event rings. */
+static int usbssp_check_trb_in_td_math(struct usbssp_udc *usbssp_data)
+{
+	struct {
+		dma_addr_t input_dma;
+		struct usbssp_segment *result_seg;
+	} simple_test_vector[] = {
+		/* A zeroed DMA field should fail */
+		{ 0, NULL },
+		/* One TRB before the ring start should fail */
+		{ usbssp_data->event_ring->first_seg->dma - 16, NULL },
+		/* One byte before the ring start should fail */
+		{ usbssp_data->event_ring->first_seg->dma - 1, NULL },
+		/* Starting TRB should succeed */
+		{ usbssp_data->event_ring->first_seg->dma,
+				usbssp_data->event_ring->first_seg },
+		/* Ending TRB should succeed */
+		{ usbssp_data->event_ring->first_seg->dma +
+				(TRBS_PER_SEGMENT - 1)*16,
+			usbssp_data->event_ring->first_seg },
+		/* One byte after the ring end should fail */
+		{ usbssp_data->event_ring->first_seg->dma +
+				(TRBS_PER_SEGMENT - 1)*16 + 1, NULL },
+		/* One TRB after the ring end should fail */
+		{ usbssp_data->event_ring->first_seg->dma +
+				(TRBS_PER_SEGMENT)*16, NULL },
+		/* An address of all ones should fail */
+		{ (dma_addr_t) (~0), NULL },
+	};
+	struct {
+		struct usbssp_segment *input_seg;
+		union usbssp_trb *start_trb;
+		union usbssp_trb *end_trb;
+		dma_addr_t input_dma;
+		struct usbssp_segment *result_seg;
+	} complex_test_vector[] = {
+		/* Test feeding a valid DMA address from a different ring */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = usbssp_data->event_ring->first_seg->trbs,
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma,
+			.result_seg = NULL,
+		},
+		/* Test feeding a valid end TRB from a different ring */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = usbssp_data->event_ring->first_seg->trbs,
+			.end_trb = &usbssp_data->cmd_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma,
+			.result_seg = NULL,
+		},
+		/* Test feeding a valid start and end TRB from a different ring */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = usbssp_data->cmd_ring->first_seg->trbs,
+			.end_trb = &usbssp_data->cmd_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but after this TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[0],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[3],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + 4*16,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but before this TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[6],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + 2*16,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but after this wrapped TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[1],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + 2*16,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but before this wrapped TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[1],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + (TRBS_PER_SEGMENT - 4)*16,
+			.result_seg = NULL,
+		},
+		/* TRB not in this ring, and we have a wrapped TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma + 2*16,
+			.result_seg = NULL,
+		},
+	};
+
+	unsigned int num_tests;
+	int i, ret;
+
+	num_tests = ARRAY_SIZE(simple_test_vector);
+	for (i = 0; i < num_tests; i++) {
+		ret = usbssp_test_trb_in_td(usbssp_data,
+				usbssp_data->event_ring->first_seg,
+				usbssp_data->event_ring->first_seg->trbs,
+				&usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+				simple_test_vector[i].input_dma,
+				simple_test_vector[i].result_seg,
+				"Simple", i);
+		if (ret < 0)
+			return ret;
+	}
+
+	num_tests = ARRAY_SIZE(complex_test_vector);
+	for (i = 0; i < num_tests; i++) {
+		ret = usbssp_test_trb_in_td(usbssp_data,
+				complex_test_vector[i].input_seg,
+				complex_test_vector[i].start_trb,
+				complex_test_vector[i].end_trb,
+				complex_test_vector[i].input_dma,
+				complex_test_vector[i].result_seg,
+				"Complex", i);
+		if (ret < 0)
+			return ret;
+	}
+	dev_dbg(usbssp_data->dev, "TRB math tests passed.\n");
+	return 0;
+}
 
 static void usbssp_set_event_deq(struct usbssp_udc *usbssp_data)
 {
@@ -1187,6 +1351,10 @@ int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags)
 	if (!usbssp_data->event_ring)
 		goto fail;
 
+	/*invoke check procedure for usbssp_trb_in_td function*/
+	if (usbssp_check_trb_in_td_math(usbssp_data) < 0)
+		goto fail;
+
 	ret = usbssp_alloc_erst(usbssp_data, usbssp_data->event_ring,
 			&usbssp_data->erst, flags);
 	if (ret)
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 7c4b6b7b7b0a..3075909c2e31 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -73,3 +73,79 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 	list_for_each_entry_safe(cur_cmd, tmp_cmd, &usbssp_data->cmd_list, cmd_list)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
+
+/*
+ * This TD is defined by the TRBs starting at start_trb in start_seg and ending
+ * at end_trb, which may be in another segment. If the suspect DMA address is a
+ * TRB in this TD, this function returns that TRB's segment. Otherwise it
+ * returns 0.
+ */
+struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
+					struct usbssp_segment *start_seg,
+					union usbssp_trb *start_trb,
+					union usbssp_trb *end_trb,
+					dma_addr_t suspect_dma,
+					bool debug)
+{
+	dma_addr_t start_dma;
+	dma_addr_t end_seg_dma;
+	dma_addr_t end_trb_dma;
+	struct usbssp_segment *cur_seg;
+
+	start_dma = usbssp_trb_virt_to_dma(start_seg, start_trb);
+	cur_seg = start_seg;
+
+	do {
+		if (start_dma == 0)
+			return NULL;
+		/* We may get an event for a Link TRB in the middle of a TD */
+		end_seg_dma = usbssp_trb_virt_to_dma(cur_seg,
+				&cur_seg->trbs[TRBS_PER_SEGMENT - 1]);
+		/* If the end TRB isn't in this segment, this is set to 0 */
+		end_trb_dma = usbssp_trb_virt_to_dma(cur_seg, end_trb);
+
+		if (debug)
+			dev_warn(usbssp_data->dev,
+				"Looking for event-dma %016llx trb-start"
+				"%016llx trb-end %016llx seg-start %016llx"
+				" seg-end %016llx\n",
+				(unsigned long long)suspect_dma,
+				(unsigned long long)start_dma,
+				(unsigned long long)end_trb_dma,
+				(unsigned long long)cur_seg->dma,
+				(unsigned long long)end_seg_dma);
+
+		if (end_trb_dma > 0) {
+			/*
+			 * The end TRB is in this segment, so suspect should
+			 * be here
+			 */
+			if (start_dma <= end_trb_dma) {
+				if (suspect_dma >= start_dma &&
+				    suspect_dma <= end_trb_dma)
+					return cur_seg;
+			} else {
+				/*
+				 * Case for one segment with a
+				 * TD wrapped around to the top
+				 */
+				if ((suspect_dma >= start_dma &&
+						suspect_dma <= end_seg_dma) ||
+						(suspect_dma >= cur_seg->dma &&
+						 suspect_dma <= end_trb_dma))
+					return cur_seg;
+			}
+			return NULL;
+		} else {
+			/* Might still be somewhere in this segment */
+			if (suspect_dma >= start_dma &&
+			    suspect_dma <= end_seg_dma)
+				return cur_seg;
+		}
+
+		cur_seg = cur_seg->next;
+		start_dma = usbssp_trb_virt_to_dma(cur_seg, &cur_seg->trbs[0]);
+	} while (cur_seg != start_seg);
+
+	return NULL;
+}
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 9dba86a0274a..927c34579899 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1711,6 +1711,11 @@ irqreturn_t usbssp_irq(int irq, void *priv);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 				union usbssp_trb *trb);
+struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
+				struct usbssp_segment *start_seg,
+				union usbssp_trb *start_trb,
+				union usbssp_trb *end_trb,
+				dma_addr_t suspect_dma, bool debug);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
-- 
2.17.1

