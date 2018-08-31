Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE1BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5362083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="qw9CMlXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5362083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeHaMRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:17:47 -0400
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:34587
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeHaMRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvOGfJpDKs+gi5Rq8WSXZkhdWUYFGnV8nsR6r+7oxRc=;
 b=qw9CMlXRYk7tpmrE7mr+yjL73EaAjQ+zi3s9+rXvDpHkAUwvs0te/cFwo4gxAri2Z5u/wiRImRD4LoZ2GUyt80RkUj4dTmnl9Vj/y+oulzcO4kCmcMz8oKo/D6j0Iewv3FHOQXys4MvwXwjKlooS8iYoLQwOMWJwqXI4Q4fEcLE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Fri, 31 Aug
 2018 08:11:14 +0000
Date:   Fri, 31 Aug 2018 16:08:10 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: mvneta: some small improvements
Message-ID: <20180831160810.2539ef4c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAXPR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:402:19::12) To BLUPR0301MB1571.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b655b5-0d55-4d06-1d16-08d60f195376
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1571;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;3:qcuIxDMnmh6g40WWF7Wq7MG2I70xOacPYpBeHjawBQPCU/X7W4UFI51q9x97fPcdg4Mg8oEL7TKyVFlLohM9Pg+4lPB5ZhFsjG9r+kBj6Y2hZeh0fMnQB5kG+b39WcUlOOKM2fHgaAqvRfH3RWL0jthSW6Ki2n1zJxeRDPqQDCGdKT9veBqIkiOGDjFdYKftsW+XIJ5B/DFJlPEUtRh1R0SgXWH0B4mFeP3HI3sfOfe9uXbHzekhMROxhQQcY5GZ;25:uoi1uuWrbqN6mOgksJr09S/FvcL4Z3yuyA6SV47J6TCi3wW+UeKUm4hA/WD8dqUod6cS+7Z6ty/XguTkzMN6AkrC8eaBqvt4+pe6/xSfunFv1JV6sSUTZJxEhV8hLgVvbC0FLc+mai4hBqPvKGaEzjTJU/W7Sq6x69nhC0Bj3NnTqTrc4U8dJEtF+zgGQZKH6qbahKG7kMu4V+vHcWNE5d9ikwaLHzhgoFAHAOnwRwGHFJ937HhTR3UqGxmBpiD7m3STIYzi0Fe5W4CVONHRPuWIwYUhav8nCeKV1mA21uMNrM+n3V4CQIOmq2vJFG03GS95Id0+q0B0Uqm9e1+i7A==;31:S7FGH1XKFOFj1ZA2w90tAXPc3o3N+Z1hjxp9AEdj10bAqfATdU5H4C3Y+GbIiZhad+r7cxNxwVQP/ZbrG147dP7Vc8yJsrNw1e07CMkTU6vgEG8A9yS+raxIHMPgKJYJmP3oqY1mP/TaCH+ygO33ctXIVaI8Q5X67nT9hpwTUnhdstsPoSKAqEEbstN5Fw2OFecMKBH+k43CqJScVBycI/jBqk8coP6YAoReppJ5Mrw=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1571:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;20:ocZlPGF1jEmbxiDwWrdtoMgr3RJV1vCjON8KqPIZGyWIzob22pglhEOUzEDytjlXYWtb6XeNiEim0M0a106s4fCkagI/jOT03sW1V7NxcEnIMz4gzD3hykY0JP172JLSpItM943Ot/I/sqi420yMMtIXd1LeRIjPYdXD6+6zDrAK5nL0rjQVCc666lwJPzUwPIO8XvGd3FCu8w/L4KViEjGhtqXV1oNo5Vjg2GAFhB9ByfLvk+5dEx9/WNRLuBZ6g5A4oEA4e8/k6Tgl+oW6UuOM54MlS7TEtFw4Rsm9tMKKWBOLSV4LI80tYiN+GSLglr3eSZH/1+S/FWLRVjG+71GzFgTuMSdAOLp97IL+H9jVsNzK8IR1lZNFkilvYUnoWV9KHptH4LjLxORndQEwn99YitJd97g/kFGg+SMB2apiPjQh99ASii91VOwHSinK2QT90h3U7kbKu77ombfZsCaVi+5+sRzUJrWc9WquXCAopmI06GeFrEoZtHnN7OFs;4:bcMqnoipVhlB3G3G3oHKceuMaEVMpoJYTGobt7YL6Cdt5RDyeL2kv3pK8r4oEiWpe+bbDRPDhqQISYognnhbh4Ou3W/e908jlJQ2VD0qM+rYiGNz6lMIOKenFfGf3IcxJxvoTp1Ml+QQDMWCGjggX8YnzCHjS/B0yRf3RYCe/JDIqvT3TKPmAf8DzAWj5UN0/MQUG87bAZXDv4TLLRvVB+4i5dGDN34aDLaQ7Iaz2LV2fwg9kzHR0lDdeqqI6Ag7I0AFl8JuunWw1gWbfszS8Q==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1571AFDF7C9DF6DB2243E4EBED0F0@BLUPR0301MB1571.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BLUPR0301MB1571;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1571;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(230700001)(50226002)(86362001)(1076002)(47776003)(81166006)(81156014)(23726003)(8936002)(3846002)(6116002)(50466002)(6666003)(2906002)(25786009)(72206003)(105586002)(6506007)(386003)(4326008)(106356001)(8676002)(5660300001)(53936002)(26005)(68736007)(97736004)(9686003)(16526019)(55016002)(305945005)(478600001)(7736002)(186003)(956004)(486006)(476003)(33896004)(110136005)(52116002)(7696005)(316002)(66066001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1571;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1571;23:4BAKKoNahT4RYD3QIq3H3vDDjFKaDAuPCio3nyN?=
 =?us-ascii?Q?Zh3bcQKV3G7Eysm7hLsS+VB7m98clxNrJVPKeVM3QRFdCtkU2Kmhdms02+/J?=
 =?us-ascii?Q?CbtMBKc6Cf4eWmGXSNDRBMp/NmmWGpFOPKZ8KNbRLFpBwOdPBjSx+/CQf95F?=
 =?us-ascii?Q?1MqXBsHrOIO14xGV5OsgOc65xbJp08nz4IhQbotrID6NvW67FVcuP44ymZl2?=
 =?us-ascii?Q?4CL19LQBEwKaMos3IiVhRNMCREIA3JTdU2GsRLmV6qGz5KhjRfSEiLY/sWir?=
 =?us-ascii?Q?2zbNhmBOJ22o6/m0NCY9TWCg/CFk+pjF1yZZtR3BhFK/yizMGgNYRwHFGcMo?=
 =?us-ascii?Q?EmyM5h0nTfNVRUy5yy+LTS8Et1Yu0cbf95shHJOmOXM0QlIyhbazr5UotNUI?=
 =?us-ascii?Q?z2yAJl1B0CO6ygnV9tnV9eIuGZ2/LDqHtDA9T852srC05ES6V1ij+VeetRAW?=
 =?us-ascii?Q?vor5optGBrGQzIioSE7ZN05UTzfu0U2ABepQwt1vNS4YCKLsQm+1/Nt3uodL?=
 =?us-ascii?Q?D2uceZv8/QJo8nENnzg0knPyIu6uXlaB5s3QgZNRLIWopY4HHJdIP9cZ88sz?=
 =?us-ascii?Q?w1aUX0gMzaVcozeBxhAKgJzAPRoEHuyzf/VbHZtDZBMWmNdPnIKQy7XA/XQQ?=
 =?us-ascii?Q?G094/WC8QkAO96rBvzWOjRkPBN4VDlghBsOKNMGeoX9uj7v040twB3DV58yO?=
 =?us-ascii?Q?my1V6CfmUlp6IRxEfANoYQ8+4C9YpJYXW0BfB1tz5HXtEWlXqe4Q5q1G25l0?=
 =?us-ascii?Q?IV+jH4mAEE0fwxKfF2KsdVMkrqE/JfWKPhQJvuDNGJ4qMMNS/oHzaZJ635+/?=
 =?us-ascii?Q?r3It+V40CtN2GSB3vRimeZ4kE+TJZvHyUGe7Af02FcnkNa5II491E7NiV2WE?=
 =?us-ascii?Q?DseGno8GFH8tv9L0ZS4i+yKhcNKZ/sUzvSHBpMQMWAqbuLTmGtmshLzNyoid?=
 =?us-ascii?Q?UCJpjonb37DZB+FsRzsmQEAYMQxFc5FfkeHISgcUC2Dm67meubsfJDfQWkHj?=
 =?us-ascii?Q?VMGeX9m8MWRLS9mxc7sNNBdQPxgiWFDnGtZAlQHZzXeXgKJ5q8AFWE5C2RiC?=
 =?us-ascii?Q?Dindv3NZde7/P+5ZwiemzkvbQar1ANkMOtjH62a/CxE+GBfdaTB/Ptvf+PqS?=
 =?us-ascii?Q?dEVnhDISTs5zQjr2zzyfOtzwjU0EeZWE0IdqtpIVVyC74zGoap41ApQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: dJOWtTwDcXcirkwE0sIdAXdKnm0HVIMRDNg4FJ4hqURV8Aoiogrd8p1YUPnVrZBdIyI+0fW9Xbjh4/N0r6BFnfZsnGAPw8BW/aAeijtIBUjyFdHJmzPXPRimXACsxQd1vHhZ1A6O5/I44NB5AP0RiepqGqWNNx7qpq3Y3d2ShFOysePykMlIGItWVLIUKLZC0+5k4qAWiUd/xJhSj5J2HyLedQyc5kjd7EmHzL9J4GSl6UNBgPWakjM4ro7xXlU8m5dpzTXpwDjFowmsAUH29Yx2ViIY5EOFrAF+wYOyGUWJxFO4EE6yyc9RpgQl6CZ0SW3MM3/aVsolYB5M5g2KhxO2tdOw5pE8v/GkgpuPW30=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;6:j6vIVBzYB0Pp6L622lknXoaiXTEht2X7gUDvxL3kZ9SS2CjeHwXt9DJ7KlKvHTbGpt0ORRsBLo3iNLFTnb+OX5Mv4aVqILsnj7pZOvXRQxPCoUMaHtq2WFs299JBLVC8UehAmmjBmCo+9YL8wse36rQN42YbIVtHMhftvQ6MLGNEf8//seZzgjCCKsa48RtkcwxDIIHFpG/0PH7WNYZtO47dGmVeRm2g1cCa4KXOJsNFuf/tucB6c+vLVlzm644Rc+GsE657zAaJ3obOCcn0zvXcHdPgUIcpDEOux+f+fnv+6iSYC8aY+DVktNC487V9zZXgEoNXyGp+jJ+AEjWga8W0+L6ZQT3oLsV/R0V/HZYjouvV+AcykxvJ64f3m0rCz3xNXufq0m3usgjWlcHpa42zDBy0t1yEg15sZhxRB9JChscL8HiuBfWRpBtHj7Y4gOjK1dlUx2VrxYoyqz6tuA==;5:Xnaf6lLqfzYy/g4PliGS6O/IS7DP8c4Sn8JobWqOdrp8GxLvxFTns75zqNd3oOVJqE4HO2ZoauSc6igzXGrBDnEvhH9pOt3FA/Dk3l4WIPmiSy/3qhgQ547xZ+n/wulWsdeSRDri8I4w92gow5vGQGuWLP38c8kPD8h7t01A6j0=;7:CZCn+fWCPRM8PEpoPQWUBjtOgOSKrqnwQyFJqbO6Z4lPbhMamOtnh67UPwkTooX4hJi0NDIPNRq7TfnK9mC/fvwvqXUo8s/TraYPxHQvoNYStH/0V6m0wxwrpiLAtzR6XBIt5bjNYwPN4qRYD4o+mHz79KJ6p0+DG4jBto7cJUArEdQqSrJ1N13swJxFCkglToq4P7JlHFkUZJJCKVF7LIPjEtaLeYqUbQ9Kiw8ev0JnOvKu8LD4xDAIuDGSnMro
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:11:14.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b655b5-0d55-4d06-1d16-08d60f195376
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch1 removes the NETIF_F_GRO check ourself, because the net subsystem
will handle it for us.

patch2 enables NETIF_F_RXCSUM by default, since the driver and HW
supports the feature.

patch3 is a small optimization, to reduce smp_processor_id() calling
in mvneta_tx_done_gbe.

since v1:
 - based on net-next tree
 - remove the fix patches, since they should be based on net branch.
 - Add Gregory's Reviewed-by tag

Jisheng Zhang (3):
  net: mvneta: Don't check NETIF_F_GRO ourself
  net: mvneta: enable NETIF_F_RXCSUM by default
  net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe

 drivers/net/ethernet/marvell/mvneta.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.18.0

