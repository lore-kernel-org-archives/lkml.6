Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1885F21916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DzexfvJv";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dEhMLrpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437096AbfBNTqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:46:31 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57384 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730888AbfBNTqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:46:25 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EJgrWd020684;
        Thu, 14 Feb 2019 11:46:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=LXPkYSOfvy92H377Snv4uP51s5pghKsm6cCTzy0i1+4=;
 b=DzexfvJvZwFxMG/PMsjMO7ejcCsq5rL65mLkhKSaQ+CY5CCtHMNj0ou9Ol52SeL4Cyly
 o0L7RFAIct/7OhidBU+R6t6H4Zw4NTdcNfWU7NPKQh89f6h1hiDBjjXuU64xvzsNTKpx
 Gj48FcPZcUpzgHu61qleHCW5bi6AS7a3reSDvxbniYNkME2dprtuOcovDLKt/N7Fzsa7
 DL/fAjBhGIGJHEJPzpVFufggUvgJqSUouy1rU+bgItURU7EHmi+XU7StDoOBFaQdS/pI
 FIifYp2jKmtoalH1XbXzRt7efKFLFEc9SZoc9NqO+07cJU4nJYt3m/U1yNRYdTEnW1JI Yw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qmt3v4vpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:46:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXPkYSOfvy92H377Snv4uP51s5pghKsm6cCTzy0i1+4=;
 b=dEhMLrpfDm2CpkB2QAKtZP12Y0tBLplEAWzr5c1Mci4sUWaztecnbVoagGg+WH32VfbMUXC0tUDY6iWcXl15QfDxey/EUR1qtKt/f0oOuklw+pC5SO3OLABLgrXQ6z37zi8QgDHnf8fKfLVZoTjKhZh6qPJBZLoQe5zvTsCf9ss=
Received: from CY1PR07CA0030.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::40) by DM5PR07MB3100.namprd07.prod.outlook.com
 (2603:10b6:3:de::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Thu, 14 Feb
 2019 19:46:06 +0000
Received: from CO1NAM05FT057.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by CY1PR07CA0030.outlook.office365.com
 (2a01:111:e400:c60a::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 19:46:05 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT057.mail.protection.outlook.com (10.152.96.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 14 Feb 2019 19:46:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2cQ012765
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 11:46:03 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 14 Feb 2019 20:46:00 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 14 Feb 2019 20:45:59 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk0W8031364;
        Thu, 14 Feb 2019 19:46:00 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1EJjukZ031193;
        Thu, 14 Feb 2019 19:45:56 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 0/6] Introduced new Cadence USBSS DRD Driver.
Date:   Thu, 14 Feb 2019 19:45:08 +0000
Message-ID: <1550173514-23573-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(36092001)(199004)(189003)(107886003)(87636003)(426003)(476003)(36756003)(42186006)(2616005)(26826003)(356004)(8676002)(478600001)(54906003)(7416002)(16586007)(4720700003)(6666004)(316002)(6916009)(486006)(966005)(47776003)(4326008)(126002)(246002)(50466002)(86362001)(336012)(48376002)(105596002)(50226002)(51416003)(2906002)(14444005)(6306002)(8936002)(106466001)(2351001)(186003)(7636002)(217873002)(26005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3100;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT057;1:C8L5+SBBe7/t8x1xTAblvnTco9lf8NwcNTx2AdJnpxuY2/VHLddq/f8EY7XqTxddxFJh/WjODMniSTlLplZHs2dpn9HTnJLv0Ez3fTQ5m4+BZBN/inSNMKQBgeLwA8BQRQmCAdcK3RtLtijFQTYncyIWF8V23/6VMsxgjskVbhc=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 271a88bb-3ffe-4407-ea70-08d692b50eda
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:DM5PR07MB3100;
X-MS-TrafficTypeDiagnostic: DM5PR07MB3100:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3100;20:2SwXgVlXTviF1aqpDxVLOFTaJW9UwOfUfOYL4LZt3MRtBC8gQos0s+0OSWnlcXWz6X829/sBcpFpradnFmelL2ANraupX0hSs80SG8OnasvNGLU5eflqWSlznr9BSVdwlu53jwBjmwR75+oB2XAZSQil4BrJX06QqspYa22RYZQIyGFKhfaEESIPM0iwIoBq4NIg37QKcT4lwnTFG4+SEHuCveoWx0GcZ6c8DlA8ucSWQBTU5QPrVDxukW56UjV4vCBcVDe89zJr7PlXbjpC5fdV0mgjqbtJEvlaJLcA66gAhy6zsEeBx5TFzMnr/9h4PiGR878rDD0US8Ed14/rbkMSpJv/xORKSooX3SNnPnhC7BOMmNrGUYNenJ0duG/gNrpIgFjhc/cnUjHmSO5X7f0s/pBrhNLwJkCN+jvZ3jPveU/d6Hirt6T2DEVaYqmf61Cg4YEnKNTiPHXPEd9bbz7Q5LfUu3zFyXDsFk1C+oF2578QwvbJ/cUsqNb5h7zi
X-Microsoft-Antispam-PRVS: <DM5PR07MB31002045CB30F27A812646CCDD670@DM5PR07MB3100.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3100;23:NNPvT0crjE63qAC0by+SToN+uy8ZUWJMpAVEEqAcZ?=
 =?us-ascii?Q?+F+2iHaVKh6nEs9z7QwbFU/TEMC1wxxYtNDMUQ6RI1ZGTd10ezBctuO8P8iW?=
 =?us-ascii?Q?8VrrA3Ebt+GJceROXMjZvzTwsxjEOYaO7+cu3btBw4E3i93lDWRhkNNFhFjx?=
 =?us-ascii?Q?bx9GR7aYGjseCNtSzVNMWK4ScApJX5KMyEm4gyLt/Djjvq37kBUXjxtZT1xd?=
 =?us-ascii?Q?LMR/yfQgQYur8q3+MrHXB4+z3iQtLlBEb1kjFMJ1auvVjNO/BZJRHBfBrQWP?=
 =?us-ascii?Q?gfCPyncf9HMDYFsbdq9hvWeBoWG/kfgv9FklfCk8OAZSHY0vPzEcMjthKh/o?=
 =?us-ascii?Q?G7QvJVKjAgR0x+fagJjnQtVljggjsQOQOVwMfGFjPbgGmXOEj9kstN0ronyN?=
 =?us-ascii?Q?dDiPMga+UQ79lOVjSm97gPbLeCKR8DPZtRwqRCeam7YRzlLMt5r1w/gDm1J3?=
 =?us-ascii?Q?3xd/q74yeWTkPuA8Ik0EdcrgxzzrGmMsjj2Fhj/vnd2pKkPfUDf4TA2QmlaF?=
 =?us-ascii?Q?ax7eGeNncPGJXcwEoE5yJEyS69nHVzUvKrgSnpwFfuuVVWTyx5ZhnTYzQox6?=
 =?us-ascii?Q?ffPLOP43oYW37WAiwOj9ciyHvPA6xXNpcX/GC1LDtFyaEi0VcuBiq2Zq4BOX?=
 =?us-ascii?Q?ygUEatJVk2yRVR0YI85/eT2gZ/geFdqhRvStnCX9taZxxMMVGwIjKzLK7nyz?=
 =?us-ascii?Q?+2x6MBftCzid6LlnmvPLERnAX1/r/ZbbAdgbqlOQafywtdXwlvLYXLsieg1B?=
 =?us-ascii?Q?kDjWSR/O6eneE2dOBR071BTaGcyzYdB0j3D0fCJwhqqxEXJ6+WM20h33XOse?=
 =?us-ascii?Q?3u2EXIZ+O0KNZRscCFzQbCN9LoBWX6/iNHnaRIAKNzNjXja71LMgowY8AD2w?=
 =?us-ascii?Q?SOoeVBVGvy6qJ9cPztNCRLAxH58kVNVvzbSBzY//YCTcHJ8E49BFAQiYXgJR?=
 =?us-ascii?Q?JUV7PnZGxEsQKddCbGGOzkGFjSxCFJpwmUewowTPUy0trjqvXPn9GZBhM1vM?=
 =?us-ascii?Q?oo2ZuMaTJ5cMCtZsSyIsGcXUU5NoCcnYkV2rb43Tfc3C+T1/zMgMBLoK8Hx/?=
 =?us-ascii?Q?NK+b3QPelQA3Mxo5SeNAsgNVb7A197SqhmAiP3CrMQtSNY/f1Ycp2jNqWM8w?=
 =?us-ascii?Q?J9XsofDkoI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FHzuGA1+9DTA0AmfWabrZKdlvUy7mKWNPZ0dDZt/R8lsuo/VroPEABGupuPpbP7E9aJaDqnZ/4v8/obeAdvWdb4iX2hYw6xBacTw/9bFH7soAK/iFi+DPtqXwrCHjwuP1mzyQ+wRdI6lxWw43xGkdtJiD3rEqqf2B/GZgSnaLBrHwYRwWipndjMAMFguib8Iquvj55KNifwSpM83d1sQeE+1qqTyIglYXBuLz2XPt0wl0P3iISOjYsJtdBG8xVn4RJXqrBzwxome5CDBe4WqXoZVozM4kHyAihZAcfhVNcYzJK2ljPj3jGKhU5LXcsLqTghiGx1Y3UVlzGnJXTMKPSA7POGI2cLaXkquPczTbpVKkTJdr4stpa6mIt4EPEiqNXCUWOwY2Gu7PfCswEXTIRAm6cTWUnzaLM8Rw/ABJvA=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3100;20:VxIxEprVJqaPxI/dXtCaoLhixOYqDcveyOH5oGxuYnuKAl3rNSnNN25wz5ybcfHC6xnnQfiTk9oOrABIM4SwfE/9Xs4Uzg84bJMKTPHk2+2XDK2IYsrCp+VHhGCwJ8VA3ovq8zXwNSicK0X05TId+iucyeqVbb1pzqwaqUKhx61RXXbwPVugF3wSJrdti1G0tx0uj8wNdf6apOnm0NIdTnUE9MgAiE4ViTDqrhl68Kfal6JsPKQsxhTaTz+5/Rty
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 19:46:05.0663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 271a88bb-3ffe-4407-ea70-08d692b50eda
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3100
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.0.1-1810050000 definitions=main-1902140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce new Cadence USBSS DRD driver to linux kernel.

The Cadence USBSS DRD Driver is a highly configurable IP Core whichi
can be instantiated as Dual-Role Device (DRD), Peripheral Only and
Host Only (XHCI)configurations.

The current driver has been validated with FPGA burned. We have support
for PCIe bus, which is used on FPGA prototyping.

The host side of USBSS-DRD controller is compliance with XHCI
specification, so it works with standard XHCI linux driver.

Changes since v3:
- updated dt-binding as suggested by Rob Herring
- updated patch 002, 003 and 004 according with patch:
  https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/
  ?h=next&id=7790b3556fccc555ae422f1576e97bf34c8ab8b6 posted by Felipe Balbi.
- fixed issues related to isochronous transfers.
- improved algorithm calculating number of on-chip buffers required
  by endpoints.
- fixed incorrect macro EP_CFG_MULT in gadget.h file.
- fixed potential issue with incorrect order of instruction - added wmb().
- made some minor changes suggested by reviewers.

*Changes since v2:
- made some text correction in Kconfig file as suggested by Randy Dunlap.
- simplified Makefile as suggested by Peter Chan.
- removed phy-names from dt-binding as suggested Rob Herring.
- changed cdns3-usb.txt to cdns3-usb3.txt as suggested by Rob Herring.
- added checking error code in some function in drd.c file 
  as suggested by Peter Chan.
- added reg-names to dt-binding documentation as suggested by Chunfeng Yun.
- replaced platform_get_resource with platform_get_resource_byname.
- made other changes suggested by Chunfeng Yun.
- fixed bug in cdns3_get_id. Now function return id instead 1.
- added trace_cdns3_log trace event.
- simplify cdns3_disable_write function.
- create separate patch for work around related with blocking endpoint 
  issue.
- Fixed issue related with stale data address in TRB. 
  Issue: At some situations, the controller may get stale data address
  in TRB at below sequences:
  1. Controller read TRB includes data address.
  2. Software updates TRBs includes data address and Cycle bit.
  3. Controller read TRB which includes Cycle bit.
  4. DMA run with stale data address.
- Fixed issue without transfer. In some cases not all interrupts
  disabled in Hard IRQ was enabled in Soft Irq.
- Modified LFPS minimal U1 Exit time for controller revision 0x00024505.
- Fixed issue - in some case selected endpoint was unexpectedly changed.
- Fixed issue - after clearing halted endpoint transfer was not started.
- Fixed issue - in some case driver send ACK instead STALL in status phase.
- Fixed issues related to dequeue request.
- Fixed incorrect operator in cdns3_ep_run_transfer function.

Changes since v1:
 - Removed not implemented Suspend/Resume functions.
 - Fixed some issues in debugging related functions.
 - Added trace_cdns3_request_handled marker.
 - Added support for Isochronous transfer. 
 - Added some additional descriptions.
 - Fixed compilation error in cdns3_gadget_ep_disable.
 - Added detection of device controller version at runtime.
 - Upgraded dt-binding documentation.
 - Deleted ENOSYS from phy initialization section. It should be also removed
   from generic PHY driver.
 - added ep0_stage flag used during enumeration process.
 - Fixed issue with TEST MODE.
 - Added one common function for finish control transfer.
 - Separated some decoding function from dwc3 driver to common library file,
   and removed equivalents function from debug.h file as suggested  by Felipe.
 - replaced function name cdns3_gadget_unconfig with cdns3_hw_reset_eps_config.
 - Improved algorithm fixing hardware issue related to blocking endpoints.
   This issue is related to on-chip shared FIFO buffers for OUT packets. 
   Problem was reported by Peter Chan.
 - Changed organization of endpoint array in cdns3_device object.  
      - added ep0 to common eps array
      - removed cdns3_free_trb_pool and cdns3_ep_addr_to_bit_pos macros.
      - removed ep0_trb_dma, ep0_trb fields from cdns3_device.
 - Removed ep0_request and ep_nums fields from cdns3_device.
 - Other minor changes according with Felipe suggestion.

---

Pawel Laszczak (6):
  dt-bindings: add binding for USBSS-DRD controller.
  usb:common Separated decoding functions from dwc3 driver.
  usb:common Patch simplify usb_decode_set_clear_feature function.
  usb:common Simplify usb_decode_get_set_descriptor function.
  usb:cdns3 Add Cadence USB3 DRD Driver
  usb:cdns3 Fix for stuck packets in on-chip OUT buffer.

 .../devicetree/bindings/usb/cdns-usb3.txt     |   30 +
 drivers/usb/Kconfig                           |    2 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   44 +
 drivers/usb/cdns3/Makefile                    |   14 +
 drivers/usb/cdns3/cdns3-pci-wrap.c            |  155 ++
 drivers/usb/cdns3/core.c                      |  403 +++
 drivers/usb/cdns3/core.h                      |  116 +
 drivers/usb/cdns3/debug.h                     |  168 ++
 drivers/usb/cdns3/debugfs.c                   |  164 ++
 drivers/usb/cdns3/drd.c                       |  365 +++
 drivers/usb/cdns3/drd.h                       |  162 ++
 drivers/usb/cdns3/ep0.c                       |  907 +++++++
 drivers/usb/cdns3/gadget-export.h             |   28 +
 drivers/usb/cdns3/gadget.c                    | 2272 +++++++++++++++++
 drivers/usb/cdns3/gadget.h                    | 1214 +++++++++
 drivers/usb/cdns3/host-export.h               |   28 +
 drivers/usb/cdns3/host.c                      |   72 +
 drivers/usb/cdns3/trace.c                     |   23 +
 drivers/usb/cdns3/trace.h                     |  404 +++
 drivers/usb/common/Makefile                   |    2 +-
 drivers/usb/common/debug.c                    |  270 ++
 drivers/usb/dwc3/debug.h                      |  249 --
 drivers/usb/dwc3/trace.h                      |    2 +-
 include/linux/usb/ch9.h                       |   25 +
 25 files changed, 6870 insertions(+), 251 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.h
 create mode 100644 drivers/usb/cdns3/debugfs.c
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h
 create mode 100644 drivers/usb/cdns3/ep0.c
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/gadget.h
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c
 create mode 100644 drivers/usb/cdns3/trace.c
 create mode 100644 drivers/usb/cdns3/trace.h
 create mode 100644 drivers/usb/common/debug.c

-- 
2.17.1

