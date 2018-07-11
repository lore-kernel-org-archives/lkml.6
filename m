Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA07C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0704020B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="cBF2ei2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0704020B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbeGKMmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:53 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:62082
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732385AbeGKMmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIUGwOS0ZnxO7jJbtzXaKonWuhMsIv/Y+8zlBr20xqE=;
 b=cBF2ei2OblebMfQ3ujBZM9NvsqOSBRZyTHHRHEjfs4+7jqZGC5KNFV4O1wZAnDqzt3r0Fz6PSUeGzt8N1Il7RBA9XFCp0Z8Ma7LO+gllo3qV3NeUC/okgFhrvcyFDJ3uBZoeEHN7BPrc93DvsKGYOSi/y+s/8C3C5v3jdCBxRgk=
Received: from HE1PR0601CA0010.eurprd06.prod.outlook.com
 (2a01:111:e400:c513::20) by HE1PR0601MB2474.eurprd06.prod.outlook.com
 (2603:10a6:3:95::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Wed, 11 Jul
 2018 12:38:40 +0000
Received: from AM5EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::202) by HE1PR0601CA0010.outlook.office365.com
 (2a01:111:e400:c513::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Wed, 11 Jul 2018 12:38:40 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT049.mail.protection.outlook.com (10.152.9.233) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256) id
 15.20.930.16 via Frontend Transport; Wed, 11 Jul 2018 12:38:39 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 11 Jul
 2018 14:38:30 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Wed, 11 Jul 2018 14:38:27 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: fpga: fpga_mgr_free usage
Date:   Wed, 11 Jul 2018 14:38:29 +0200
Message-ID: <5553262.evi6GU8epL@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(199004)(189003)(5660300001)(786003)(336012)(23726003)(26005)(44832011)(7736002)(305945005)(230700001)(486006)(50466002)(426003)(33716001)(246002)(3450700001)(47776003)(74482002)(86362001)(6116002)(4326008)(7636002)(14444005)(33896004)(9576002)(316002)(126002)(43066004)(16526019)(478600001)(966005)(97756001)(6916009)(46406003)(106466001)(8676002)(9686003)(8936002)(54906003)(476003)(356003)(106002)(2906002)(186003)(6306002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0601MB2474;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36815d06-3959-4857-937a-08d5e72b3aab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0601MB2474;
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2474:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2474;20:BafznFwy6qelHjXtG7GntWk3Wlr/I8c+owedHS+AKoG5vHhzVPOuxN/qVw0cDgJjGkH4v/uEe1HzcA/TOptIiJK4S1nKsamI8jDLoMtl2fppYef1C70EkmSJVorwo4nJfCO7qf4Um3g9tSZrRHKi/jm3Jz4iXmOgQg2f1nThqfZF1ONk1fmssex/vo9/R6Wff2JXLc2KJhUNWnemlGdOKx9Ob5xh5qrOhPg7HSHkgtHb+QGiwKiFR8hKmqs/1swCTV49Nxu7nAt8hLWY+CyZZkNfm79hTRArBsI3UF4VLS9SR7q7z10Bbr4/o4/fb3BFF90WWy/z1u8BCGzDQQX0M0X0cN+dCux15361r252oF4iG9J4pibfAOrtypPDiaCBefWgd6hO4Hd019SI7dGdgS+J9fUJ6dn/cAqCX0mgVixQOv0Q31maPgusMdxXXV63s4qhM7DeSIoHMSna4npiaLwYbESUh/+fB3SPlJnfATfmtIOAo1vFvL5J9zAxXl0c;4:XWGG37FS6gYojpEwjfrEEZa8LKuXVreXxxNYvpXb2TfbijE2xaFydmBfcEaBFV6q0X0nHJBmbEtoYiizJWWtU5OnU61sjhl8VHELO66S2Nfp3WgwwgW+pkjnP0gPHF3/1k8DFCNmiirB4ai57jcaclkvM7LAt+/KoS4XRIpob9Vx9D8QbRpTGucQ7y8al640J0tBy28PG/CwinfgPiXrA3Jd8C/GH9S3um411LpMqBiC+QCtJdQeLzNfEYjcFP7AFH14p/pZbd0/oaxGYwTosQ==
X-Microsoft-Antispam-PRVS: <HE1PR0601MB24745EE89E1F9B465C496F10EF5A0@HE1PR0601MB2474.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0601MB2474;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0601MB2474;
X-Forefront-PRVS: 0730093765
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0601MB2474;23:Cab7dqrzzQt4z27hkzz0i4o64miEW9NftUca32w?=
 =?us-ascii?Q?ckCJEURAdbuF6gjRsiB7D5rsSIIkyV9RXtMAvaCsMI1itCwOBxdGiig14c0/?=
 =?us-ascii?Q?rWgSsrPExCN3MiBd4IXNLcyDNsF8IUCYzOiJjK1YT/1qvud4+qULZ5H/Yac9?=
 =?us-ascii?Q?6r3JSC4j57WWFUlcG4XvtKeGAMDjmLFHNOxi0/B9BpAuN3gh9RbCoYAcQmvX?=
 =?us-ascii?Q?SxI4SgB0EqbwSR0i7UeMaGNqfgOL4VuA9ruG9K1U9hm93VKFaijE0MmaZbBt?=
 =?us-ascii?Q?l6JLZKKwYzwI1FiKlUvXfNBJhXqiu3fq9KKrZfUm1Rwkv7TINMcJBbEG0e8U?=
 =?us-ascii?Q?gIgCGOfQT+DHNikTNL+AUqxp5swdYK2bJcBIXkdUqXuGsNl7GOdgKwTfhkbj?=
 =?us-ascii?Q?IpLY9c0M9szN7dNI7M/zNFErXLcNKRGw9e8QlGjgMzLElxgcFee6d6nyvIkp?=
 =?us-ascii?Q?XF8FXzrAgRnSbjQRCgxuqY1dtdhs05zEGgRDCF7vUt6AnyD1+fDwHaoGi2s8?=
 =?us-ascii?Q?3cA+ZPO0g9dfV9QIu8+A4DnjFkAHN31rzOXwqSx1j1buUeef25/OkA2GRSa/?=
 =?us-ascii?Q?DazOi+U3G1i9bfJ1TgDn3F0zjPun7CtntTyRtBH4NudBOW2l71Q1pmF2i5pZ?=
 =?us-ascii?Q?8s0qeHp/grGH78ndz7YdUez24rt+zrHppC6zDr0dRmkdxxIOESE7E4wbvVTs?=
 =?us-ascii?Q?nhgbdVOHEL29q70IZFbsjpeEJg+cipKnJ9vRmJIb0r4a7RxjqZnAbROs9mJ9?=
 =?us-ascii?Q?ozSy4Vv4a04aafqSpWQEUj02H0daUBijwZnEhnvOdtSwiD0DtyB4OfCLibI1?=
 =?us-ascii?Q?pORuaEggkakRkbgiP3/DqR1dZtkJxjJSaTvS0Z15Wz/bgRaMsC3Ur290X1eV?=
 =?us-ascii?Q?T2BNRkVSAzStzcVJOxZHR5oLusm+SqxSpPfk5m2MNkmVbYlyZyaXktuJh8rv?=
 =?us-ascii?Q?9Nf1O/lh0OVyTjB9Ibv471lDlp/6m5uVzC8I8qE4EWdwYcuvyvPK1lpB+PjD?=
 =?us-ascii?Q?m8AFpQlCvsC440Rzj4xJHriCVT2MfVCH0lykmGCQrNo1WfhbBBgCmrj7lM7E?=
 =?us-ascii?Q?/RrpWwPoDVG8nYWeKsXCpSbISFG3lD4woQLg6doK0Rqee1BKIPuqIAYgXJs4?=
 =?us-ascii?Q?BL7kuS1LWXBH4r7oyk2mb4AqXuu5z3VOL0FhWJYm62XKhmjz4FTgGMNWS1cO?=
 =?us-ascii?Q?jWzO+/Y4cE2AxGMA=3D?=
X-Microsoft-Antispam-Message-Info: 8dvxaJMJQyDwM431nvOJmNKmH2aO+IAkh2LEzghQOMqK4i3jBtMfHzR1AYX6kFPVG2fbknf5RqVcrHoThd68cNTU7OPI+FoGZD0MqEEdV2EhE8xstzfrf1jm53BnZAR18Wop+41jWo3ZozPo9Ic/2HERMhHGvuwsSY504dS/DV1h1I7l47rT7/jNzd4gLzzsOXySdC57VfzUeH81TKMaHgtSNakg4Xs2JGAQmkL6xFE8w2+vthZOBabV7NOmtUmxckYwEzBH7k08+UPwippfhEfj8PCiwPSMhy0QGussGHqvlcGO3HLErh27vlXKcM9C6ssWwB72jbGI7CUDyOGjd+f7nUAdXNemG5Od/P/rrRg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2474;6:g3nzoXPOpxpbNvQ10LcHARsjXU8J4EJfMMWerkV8szKkZx9zHemlaEM0Si4hltSQTWvsQoI+wIiZ5XZDEFlredU0SshDOsWWCGy+6822IlH9s1mhtOWmtDh/+p8ssPVHAPF8Q5EMS+cx++gCy+FfBaxMW2BWnikbBZsUdpGXLGh+DQbjTQcqmJxYP3cpxo/V7yibAzOXz56Ftwsv9BKzFdUBCb9hG+LsQmMs2ADfaWyA8JL5IdXL8kM8X8rrlzx/PArQmV3plVVRzCrvfHQjLLYo3eOfpksG5BWeGWt8LbNoba9T3X+/oZpIH2ZGMTgUb82EpvLH7nd5pI+BAwRttIForlm9Um0AQP4A5V8px3ebpuTHIJ1EPu8H/JvmY7aE4eH+rc6WNp2zOCcZpi15IKKMCQJyw1gr29V9qQlPCUt9VMJT1932bKU1twjQ9+k9hCUl3q/Yb5Z/iBNOdsOmug==;5:M72L0ArNpg+pccOV9Y1+PWZl4gGBL98hdHuuyXWy0yy9InosMRUzYA00iWUbiRDaEb10CH/QI6o2tCkQwstsf93spUNgb8gVSV342CbjmecQjlAgHx9aoUvrktzj5fZo7JU02B4TSZi4bNU9I4Zt3UwDyP2fGaEZblntgWidgDU=;24:1KJj4Lepw8AshhqiW4LPWsebLRKqBUjl8k/q4paFLfYEZIv5hQDfRSs1HJ9cnQ09p8MhIuEKi4g6oG6GrzKo+Kex+/wu7lc9o/A7lW7+GnA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2474;7:WCTShL7mlTfOb6ZRjB/Tpy6M0yYDirf9dj9SaABcPFzmG9x9wHLzKgGt9zUJd0xAFR220jd7Dqsgj2wFcLA39dJwj+aWEaGMDh7wBosUbCWRwBn+wR1hVbI8ZZBR+RB9Do4L8pzSpAjAVraSANTSKQxAxy8lkXbb1dtO3QmzDNh/9NqQbIn02nFSkFt/llw6tu7uJ706LerA0y+2fNmNs4jMCPlfr4x5wjbRvwKtYL2YUpLZBvfVqwwoSN5fZ/lB
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 12:38:39.4382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36815d06-3959-4857-937a-08d5e72b3aab
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I have another point that I would like to discuss. It is about the 
usage of 'fpga_mgr_free()' which does not look like consistent.

This function, according to the current implementation, can be used by 
an FPGA manager user and it is used by the FPGA manager itself on 
device release. This means that the user can only use this function if 
fpga_mgr_register() fails (to clean up), otherwise the user must NOT 
use this function, otherwise we most likely get an oops (NULL or 
invalid pointer). The example here is correct, this is what we should 
do:

https://www.kernel.org/doc/html/latest/driver-api/fpga/fpga-mgr.html

But I suggest to document it better or prevent this type of mistakes 
from happening. Following a couple of proposals

------
1.
Document it better. This is easy, in the fpga_mgr_free() kernel-doc 
comment we explain that the use of this function must be limited to 
clean up the memory on a registration failure. If an FPGA manager has 
been successfully registered then it will be freed by the framework 
itself.

But still, this does not prevent an oops from happening.
------
2.
Remove the fpga_mgr_free() from fpga_mgr_dev_release() and ask the 
user to free the manager when necessary.

This makes the usage consistent: the user creates and destroy its own 
objects. This is also consistent with our other discussion where we 
said, among the other things, that the module that uses the FPGA 
manager can the owner of the fpga_manager data structure.
------
3.
Not sure how, but perhaps we can be able to understand if we can 
safely continue to run fpga_mgr_free() or we should stop.
------


