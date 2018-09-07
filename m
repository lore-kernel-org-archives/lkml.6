Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBB9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E714D2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FFxe6WXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E714D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeIGKm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:42:28 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:38336
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbeIGKm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06VWge/6S869b+vyvadMfSun+J4UU5u4utGVDFSl3WM=;
 b=FFxe6WXNWbVaPmhl7Uj74cr2iGOs5AVPHDvgKTMAFAheoDXKg5upEB1ROm/sh+OmTbwilQ72UJ2vM/p7eWccaBOTzxA6jgPpsDHkOa859nY4WqYksDq0xoBJNodbBdrZ3MUQwHXvg8sYclALBCP1fWVm1T2A5/oD87FhzwlZQ6I=
Received: from CY4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:903:18::15)
 by SN6PR02MB4943.namprd02.prod.outlook.com (2603:10b6:805:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 7 Sep
 2018 06:03:06 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR02CA0005.outlook.office365.com
 (2603:10b6:903:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 7 Sep 2018 06:03:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 06:03:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45909 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fy9rF-0004JH-He; Thu, 06 Sep 2018 23:03:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fy9rA-0005P2-Cs; Thu, 06 Sep 2018 23:03:00 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8762qwS015854;
        Thu, 6 Sep 2018 23:02:52 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fy9r2-0005Nb-HJ; Thu, 06 Sep 2018 23:02:52 -0700
Subject: Re: [PATCH] i2c: xiic: Make the start and the byte count write atomic
To:     Wolfram Sang <wsa@the-dreams.de>, <shubhrajyoti.datta@gmail.com>
CC:     <linux-i2c@vger.kernel.org>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <20180906185201.GG8607@kunai>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a26d5aa1-de79-c881-da3c-5be67d1fc4a4@xilinx.com>
Date:   Fri, 7 Sep 2018 08:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906185201.GG8607@kunai>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(8936002)(58126008)(54906003)(229853002)(2906002)(110136005)(551934003)(336012)(53546011)(36756003)(305945005)(4326008)(186003)(26005)(81156014)(9786002)(81166006)(356003)(31686004)(63266004)(126002)(31696002)(8676002)(6246003)(23746002)(426003)(106466001)(65806001)(65956001)(39060400002)(107886003)(476003)(478600001)(44832011)(2616005)(77096007)(446003)(11346002)(106002)(230700001)(486006)(50466002)(316002)(47776003)(36386004)(64126003)(76176011)(5660300001)(65826007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4943;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:pFLzqlX69pMHMBZR3pckhsu6euPrFhHH2aB47YF5+MjxTXsW6QOJ6Ypvr/ezLc/WW6cVQw4R/nXe38KXCWRYvuLEXRCQtyDC1XAzgRuK98xfEX/j6SvuO3ny8jn+4Mhs
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 206cd745-cc51-4979-23c5-08d614879461
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;3:4n/q05e0E4s2s8tdWwNb7j1bM27Ybq9yKgyoBczOjq5LrnudyVtoWb87buwWi33Wlq1AnY6P+MFjOgA7qp56/IGNeLd+IY0ayrMT/GoKUxwamwa+XRWACHGdsJYYlhB2jMv8T02KJI438BTy+CHu9Zs/6vJTUVW7gigvV3Qk1LO9nvVqrgeJU8hTVjh9X4RuiOlFJrILA62FIJb47QkB1LZoa6rx3D9xO6Nzt73OWdylbVYtD5UZf+EacSmUDBFMOGsVS6Cgjxx4fYDdeuGbSC055qz8s/rc24at2zfKSFSX71evTe+ext8LYsGjcQIKxG+hj7dIq5ryUyiFnbhJw82Icir/iyrW9/Zmltqs6y0=;25:9MkdL3fH5JH/X2nw78a0exPQl4InMOfr6REgUv8px+J5/pcRJWheqV+ZgFguUSaBei4pbVqX2L1HWN6Jb1C9VvsBfY8qLvLCj3hQUge/IxLcEWkboCn6+gBVxEZSjaEUwTOxM31iXpQk5MWd5Bqt0qsCVr2okTtX5MRmlUeRv3ktTUJw+YtRuu6sCKWguEW55vKb9NbHRMZuSdeMGp/0dmSYVFC1agrVjxepT5ut0iZDg8WJ7HcXJ4p7BUSOTe9/9O1yXhTrR+3ITENaV3QdoX1MzuBdgzzcogt8RTqV6qlHhksh+3XJUQR0ePg88sUm2Nx3dwsJ+TyNUjuaWYmkhw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;31:SfWNNWXN0aFO3XMYddareTxmtpo1AuNDaxkrm2ZZtlaa0O2kRUk/XMQL3ALMDKsKYWjFhY84ydX2jbdsK1rgE9JU3Rhbsbuf8MmWqK8/4SBJtLqVOjEh8SsGd9XDURtN0+EtlSiM8huEOTsxYShbnFRalPEU0u07I+TzgsquG682KfUHTNqpUCxhQ7U6BbGI+CfFiF0f4pNJzXY7RvERLR94o6z0IshG78oWBx2Zpb4=;20:Uh3u4YdB+W0t5qK9BZ3PQExsOtNR3nFhlnM2ka/BUBZhGSZl9DMFWatydH1rVY8aybw8UvocJ0dbzW+sfPPT8uiZ63xaarPpjERUDg3SVpM0oYakFjtWSiMEsJLjrunMlDwJDPKDQXcqGwbyha83QL7iiHL+TlBq6mEMuPOg0OQMjqcx4OjeFt+xT6iOgk0sqeLdDlloCDTKZmP/4LX+Nacq++R0DU12cPVuouDAoyh3Mv5oXKrygevHNFxeLYXM2CbH0vRB0p9ErrtAbvoIU8xE6eIbImapTJ7ugxBrXu5mJEf6PcV25mXD3Hjjh058rdO89zYpCXrbqW/gf67TCNT1QBSyyitX8w2xN9wckFX8xLA6y7X7t30RJkxgIilDPVpUjFnnzdXRYBmUDgHR+unIjCCNPG3xOucLQnAikmZ8X+Tq8X6R/EkITUIrbJuuqXs7rIaa7KpB0qr0t6xSAU7J9sY4vaqbDAksaMjmXtq4BtRvAYL+sBY+c1mGrsdl
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB49431B5335076E6C4CFD4A3FC6000@SN6PR02MB4943.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;4:WMzmgyEn73JS+BYY5h7wTnbiB/xEz+9+FlxcgxBITzy3yhVqoM9EOndaCGP4aQze+lcyRLYx8FJG+DiZkbJcpN0EtnMDlChET++0kMw0oECd/MugHlX5knLFmpn9mO2L4qXp7ndcEBQgdm2e9JlcgnRjR9Hg7KkJVBwF7YJyJvxDZd7RejltCJ91xxHHLlggahxqQyAgFZjq95tepfN6r0iNnKoa88wcaNIK1qAnF3/AasWZ5MVLJysCMtBbHz6BoQf197XihuKe2S32xfZTZ+fhQ9ZuslMKpcF8A+8EpmKf4T4+1ijyffB/puCtNgKeXIP2QJjE7pps5Cg/jHfCodRAesOuyXIY7u7OlQqWR9Y=
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN6PR02MB4943;23:dDMlh65uQ5o4Kp46zRHvRPwbg/a1dG1vDy1JP?=
 =?Windows-1252?Q?Xk3J1DPkyhNXctvJ7qgCKfvSCeE6ealSfvwPqQvciE4pH8jlaJav5mkS?=
 =?Windows-1252?Q?ZaCz/29xRaNBUSTW3vPdd93QSta4PzQhiW7xQckgJxcBVvEoo+MqzZky?=
 =?Windows-1252?Q?tgkop4UurAwyFgoVyCiNKHNQd7quzdFpc+52z0L/xAbNhI+smjpeunLI?=
 =?Windows-1252?Q?/zA295WpzcQsRPHmUEHdAyNd+r0oQ6tqb0cogh31Mast2K8dOnXsdxKG?=
 =?Windows-1252?Q?Szil9WWEV7oYky1AJggRtzNSVaieyfGYIWi7FYOeBZNEojlVwGGQXK9X?=
 =?Windows-1252?Q?PPY2bZwb2jR7QvRKotMXy33IqY2lqPRl8uP08upNBHMPwTx/CDXftK/E?=
 =?Windows-1252?Q?o0DO5l7/u05W2ht4P1L+tAobey+63I6AQ+3SUX00+ajJEmaillE7Z6n9?=
 =?Windows-1252?Q?WJr/O586K3uWrW6e8ECSgPqg7iBcEli5nH3NjLO8K/I3DW81HgPPE3kb?=
 =?Windows-1252?Q?j8SlMhp1jq0E7Ky3F+BDImbVj1LDjoTv1ZGbykQY32JFD8WaEN1QbCxM?=
 =?Windows-1252?Q?8RrlpgZc9p9qiBCZlt9ckjo/s8Zsg/NcYem8upJeAjv2Uomtkyjl78Aq?=
 =?Windows-1252?Q?+oyEmWjoY7UBhdP6x2tnEzZi6Nbm1PgF53sVXBP3o8QIPpk3lVqCp/38?=
 =?Windows-1252?Q?TFA/sjz1BTWj2MgGFU+Su2pJcFBr7P0aGdBrK1K4jrJczbZSqCpjtvmb?=
 =?Windows-1252?Q?KyC+0MJG6IIaoK2sN6c6VSb7eiyF7umZzKvwGzpXelKpZbNC5qPwxegq?=
 =?Windows-1252?Q?wDrtxjteGTUZFrLPzxWrf2QYBmDl8gxG1lYnjkTxwaeOQWGHcASe0ODy?=
 =?Windows-1252?Q?fjeDW80pNYV/drvwLs57/AG93XRlwSbmleEQrijID0fK2fDb0MvorpZx?=
 =?Windows-1252?Q?EEM66v7K+vnov7+bCZWHSEuaIWYLmezrjyrCWDGJuXorNJp1wbGvy0eM?=
 =?Windows-1252?Q?BYGTdrhC+1iSzP6z7vQbgYAvQpeL+Hzl1+OsnpTJWPzZve/C2gp5fJRY?=
 =?Windows-1252?Q?fojn+yaihQEkDPbftT0f0Hh26PTTlWRDdyhmv58DFl0I2jXPHGjjmEnd?=
 =?Windows-1252?Q?Juk8/lcBM363KZiBWKATU3SZwPc10RWsecxtPQjQgShh2MjqMcJFQD7L?=
 =?Windows-1252?Q?soBqGOUf92aMpPkn+hxpcCe1kBuhR9fvSqGHEgj13hkkZWUJOyGCvNBO?=
 =?Windows-1252?Q?Mg2qF0x9K1h0XR0V8mrtocODBRTyOZFikX9sjoKDZvd8ntq3PO3Viex2?=
 =?Windows-1252?Q?9HNkn4+sfAQ8PynMdJALq3qgKLgS6BBma+F/6c9egZjcYKZYFrjzCmbv?=
 =?Windows-1252?Q?EUWIbKlZCvYOnoGiMFA53zkzttnkETLOuuqRUO1yLLOpemPjfJXtM2IR?=
 =?Windows-1252?Q?awAKQ+cSn3/fHIRzdzK?=
X-Microsoft-Antispam-Message-Info: psk2OtljQKPywLhwVjQI1vu3YuLGspL6Umg1jc/8ytQGTqikzNbClZssFWDzkT4pa5DGCTb+Rtz2anfQywWi+xA2jHPy0ovKEfw4SEo5aHWYneGH1yOq08D/v2MTmxVCQ7/gw7eFbUOrbyQahsr1QHULLMh6CeiytRbrFzMHRUsc0zZxi/uuV60tmrWVttkm04XguFtNiZlmMHZHdhTYnjhx08g4chAqT4cWsneHvpH9Bo5QE5ME5OJBRsmODaRwoOGnQtByz5Clqek7AwyeuBv/DNdtmWjSsMlCBKjrG2yZmHtI+SVwTehxLe3aY+/0WbbUqYiIRWc/9PQYTRKIRreH7UDVPYQkPnYakM1QETk=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;6:467nYvTatdQ3rNqgxT8/74rdyIvqEQGeHpbAOPETqtnkCpK/FSFM4ntsqIumqgt/O5WDYLnaQRlCpywXORZIhBxE+I2De960QBuB2me7dowxNWLovxvlgVzo57G/+EkXEggInHbH3tPvQp8KTFfV4IrJEVIxxAFwk1/zrvvNVF1o+9x++I+IcUoKhYZf0DCdybCHtdePxZRl7Auwr2GTsyycCRU8GBriVoO7P6Arjxp4dNnOL7m8MMhn2i8E90iNNOKUr7agQsJn6ZpWS2D6nOwYuC854qWs0DxdXUFZ5ViNr3RV9ynFyvca67uHj0+9ixjMuI91WyZtaJQNhKuhdnuduKY6Fd2WCLacH+JP6W73jtDqjZTwWoAza+c/wDuTFqokwAEGneYB7B/5YY1ZiPO4WbXNKk3U/HVjfr+kXg2FYOU5nVhAQd0O8dQr5ym8miePAXLStlgR3+D9YB/KsA==;5:GiRKMoqX26AI4zyjQEtdmwNiPzs4lsy6eLHxeSKOZxVIEaWKGKTDg7R1y+LJAx8zxFvKh0KkZY1yc6r2B/+PWx+H2c5J2ZeaqKtW0JzjgJPZxZ2fwlrw9rV1917eesZH95cIMjseowFLcxKWltUg5cZ7W7j5dD7o8jUrYiRrSeY=;7:nN65qj5TK2m6zV5HjpfsRcOAbFRoJJeVE+7Sz/M+vwEU0DQ0cxNS9tGk74SYxlyxLs/BqErS3OJgbndZo+q5JZuY8K/QBp7jlDNn28TD1AE6tzwsmDXU0hS89Ds72dXV/eB5FvJQCUr9XzcmT9qtoEHEUDcWfM/vO3DDZFYfwME22DN47sQF1LoaJmy47gFpDSesVAR2JlVndVMjfbF/JdQt1s/YZ+zmLrm5jstciG2zQc18owJTZ6uIpsRaNOWk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 06:03:05.9694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206cd745-cc51-4979-23c5-08d614879461
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.9.2018 20:52, Wolfram Sang wrote:
> On Mon, Sep 03, 2018 at 03:11:11PM +0530, shubhrajyoti.datta@gmail.com wrote:
>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>
>> Disable interrupts while configuring the transfer and enable them back.
>>
>> We have below as the programming sequence
>> 1. start and slave address
>> 2. byte count and stop
>>
>> In some customer platform there was a lot of interrupts between 1 and 2
>> and after slave address (around 7 clock cyles) if 2 is not executed
>> then the transaction is nacked.
>>
>> To fix this case make the 2 writes atomic.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Added a newline for better readability, added the stable tag and applied
> to for-current, thanks!
> 
> BTW we have no maintainer for this driver. Would you or Michal be
> interested in doing that? I don't maintain the whole driver directory
> anymore.

Normally we do handle it via Zynq fragment to have single point of
contact. I have sent a patch for that. Please take it via i2c tree.

Thanks,
Michal


