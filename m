Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A31ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4753320693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CT62tnMC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Clm1nnGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4753320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeGQT3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:29:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54088 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729719AbeGQT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:29:47 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HIqgR6010649;
        Tue, 17 Jul 2018 11:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=LHOqFfFem0+ryiIBa4yNhGNAy6GPLBJUzv986md3ebg=;
 b=CT62tnMCpGlTrFA5gUQM+li8+BZ99on+xLRxzMIsdKHh44eD2o0mr5SsD0u1vCg4yY6X
 zsoRvaXcWr5t0mEzEGzSVNzbCE9BnB6Ni/AAX3eWtssoRh5njy0Cxyt5COh+naC7DP6x
 8EKHzFk9GRK/nvHYPNnqrKzV8SnFn6xGULo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k9jw6gpcd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 17 Jul 2018 11:55:06 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 17 Jul 2018 14:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHOqFfFem0+ryiIBa4yNhGNAy6GPLBJUzv986md3ebg=;
 b=Clm1nnGhzRoL0pq1Wi483h9UfiJ1806YvJjteawuyaWBsfeJ+dLal5kF2ueBKFImxmwA+ciHTz3JjrlJNzC5mN6T7irTk6tjvN5EdrQWpzFlio/CkU4T1Hg46m3RE+P4TLx+xApm9Al8zXcOqOCgyDewb6kV/D+ZfkBGhw3xqI8=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:4f72) by
 CY1PR15MB0172.namprd15.prod.outlook.com (2a01:111:e400:58bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Tue, 17 Jul
 2018 18:54:59 +0000
Date:   Tue, 17 Jul 2018 11:54:54 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-api@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v2 5/7] mm: rename and change semantics of
 nr_indirectly_reclaimable_bytes
Message-ID: <20180717185451.GA18762@castle.DHCP.thefacebook.com>
References: <20180618091808.4419-6-vbabka@suse.cz>
 <201806201923.mC5ZpigB%fengguang.wu@intel.com>
 <38c6a6e1-c5e0-fd7d-4baf-1f0f09be5094@suse.cz>
 <20180629211201.GA14897@castle.DHCP.thefacebook.com>
 <ef2dea13-0102-c4bc-a28f-c1b2408f0753@suse.cz>
 <20180702165223.GA17295@castle.DHCP.thefacebook.com>
 <bfdb3fb1-5d81-e17c-e456-083cca04e2cc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bfdb3fb1-5d81-e17c-e456-083cca04e2cc@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:4f72]
X-ClientProxiedBy: MWHPR15CA0033.namprd15.prod.outlook.com
 (2603:10b6:300:ad::19) To CY1PR15MB0172.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0176a3d-a056-4bea-8910-08d5ec16cc51
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0172;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;3:D9nRzDbwejvvWvQQd8mpCQsiksLqDh1ddngONx3RC26eNxoi/5d/+PFzBcm6Gjm+D8da5wNg5/1w6Rh1F+1fGFIPfqW1IADupwiUtkMMipTLVpmg+QGhRo+HacNL7WTFi0ZR4QO6ZwhpK6+wC1KG6jmRaLQg7ckdj4KHy4hMVoGm6xi/Am6Y3cxRL5QN6ovOeYTTqxKI/BW2ahRkMQD1kfVXvJMmOD8hI8ZKR8vjIzfocEGqCbkvz/FEDbTrkgae;25:t6G7B9vnpzoC4YCvmVVMv2rlsGTyN/DFfvZL0KermlJNbi3sosvrNkzHfvchgzsWC0dk+0onWczCZkhAn4hEntUJFXarbVt64u27xnGInc3o1INqqqC1814jmnL868dahTVm0WlzpFZx5LL71DEvs6jIAYFSjOUGmyL1nP27wsmfyvVrGeswNfTBJm5ytrGmzZz0GImcMXoBn0CFXkHJJov28YRlPMxE3UaawXUypvVAC7jcpbUkIRQus7oJLUKSOirg+RF6zjBtsxaFk74JL5A9q6bkO1Bbp958Dnr/0jNSvuZxh3VxeaEz/WCRQ6J9+zoummhIaWAe3BeOSLcKww==;31:6HgXdb2w0Sx+AwVB786M+AKavKCRdNSuyc14nRTKBcMeG33GWTxzG95OuP0WwvPGi3ASpBsAd36G9gwRDpix3bFOcPMcIrcRPkzyHpcE3Pjl2H6bxFsbbrFFpxGhJjFea4cSIAxSNJ5YDx7tOP/J/TctsY4ADxPLTdMwE1AeTXlJ1VPhmFvA3UeUMSUK2Se+Xa3tEDSbKTRBbGID25kZojWS4y9WFCcI415DkY2qxEo=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0172:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:nJ5bzqPva8GNeUtxACdRtqjGdpjGpWo61N2ZNdBBArh1UkKLwnoG4smnqzUb/8GHKYCz/W+yqZ/h9YamUcTDPoyHlP0etu2jHn/30L5O+xVQDP70fh0K3ZlmGkVd0AyRr30Wub2TzbbRh61VgeIIUQWG1BWy+IdHlwCOfI3VkQfc7FfCorRIoZQEyQQ4SspkL1qGc5F+EmrLNqiHblKTas7+YSaMcCXu1hv8xGFih3WFJQzWSf5vbxpz324HcbczdVyB7tdVHUWfxPITBXtlx7a7Us2ElMHYy66MNHFTaQ4cY6groByOt6NjL6U0Wl8WnmMVs5scstU+Y4K+tJp2T4pmXLdz0MeFonDyDR19V3li3S9ebiWOqQZHbzxR6WJP0leoUCxhNvZ6jMCK7GGBItStjX6P2y0k9eaan7G40za5NnQDBe2guzBUcForkBf+N8VOAccj8oTRj815fYX2ohjUevo3nG8wcypWh03DhD4s1VNrp/6EjxZ4toCRuiky;4:bHYfzsVBX6iZjfbRCeyojW2ULkp9scAksBHTxL8ud0nV9dMdj0GF87YbMcAIoj/R9FeX0v/hkO85m20ou0uV2rSRA3NvYnVpGS1fQoMexTGPI77fEvSQlDF7tlUOtXTLLVoITZ7u+xlvIUnUN/rn2vNh9Xm77xAcKi7pSvntInEfjyw17Wbw0Uar4rO7U+Bq0SL+MDcdPHzL0rzBYt0V15/jz8fUtc9G6XWnFlkMFEVao5xIonY3G866i4e4nx00jTXyP2IGSnQE51xnw//zUg==
X-Microsoft-Antispam-PRVS: <CY1PR15MB01725C1541510B6038FEBF6ABE5C0@CY1PR15MB0172.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0172;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0172;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(46003)(8936002)(97736004)(23726003)(305945005)(486006)(476003)(7736002)(47776003)(7696005)(11346002)(446003)(52116002)(52396003)(1076002)(6116002)(76176011)(81156014)(81166006)(8676002)(55016002)(6246003)(53936002)(86362001)(25786009)(16526019)(186003)(9686003)(4326008)(229853002)(14444005)(33656002)(93886005)(105586002)(106356001)(58126008)(316002)(54906003)(16586007)(478600001)(53546011)(386003)(6506007)(6666003)(2906002)(5660300001)(50466002)(7416002)(68736007)(6916009)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0172;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0172;23:byCFBKG64lDapy4qKrdjxb5fPx4kLtFIM6P5o0Nbx?=
 =?us-ascii?Q?0Fs2gj3+HtTehv7yNBxzEvuUwdGPVm/ws+LVbcTQFPxZBJcL8ZM9cPBuoM6W?=
 =?us-ascii?Q?iVp8GcbiDmvwRCw0zFMw5AwM5JL9txMALQuxGzTs6JRbrBeFHw0V8vDKjlvC?=
 =?us-ascii?Q?6ZXmSl8MZQkdKM4xgDJkVVKDXuvF/75DmbDgSF9lTwiv2RTD+/dLFd5v2adi?=
 =?us-ascii?Q?Uk/pVCGSMar5Yoc8U1qZLPnUtADpu09wUfTPFW7s/4JTfr9DHClaX9SptGkg?=
 =?us-ascii?Q?gvYfM1XbuhRt63lXX4WD3W7a00Xoflwl/X2RDXdBYgB1FBwskkiAga68mt9T?=
 =?us-ascii?Q?KLPtoY/yUOD0FSF9ldKZCMOu83NLpBX8AkkHRObWtLZFV95Bj1E9HvAigN3+?=
 =?us-ascii?Q?8rdJ8pruvwwezO+EhOGl0doRpRt14IXo0A70Yizg422wCYQCZBdeYk7KSTiw?=
 =?us-ascii?Q?cs9dHcCfhSxjmvsWmZGftFxfHlxBQF6rzTNh0KZ1kpOT2dj56CjaMjMCDYGN?=
 =?us-ascii?Q?UaejNXmasQSarDKAVg6Eio4Qo0Ua0gNKoWxoMt6JVS3imfkjPol+aRuKActv?=
 =?us-ascii?Q?qGLKi3h0QKq6Fw9yOIN2MDl0PID0CmoShlt5bNCFT5Vt1y4yjl9qmvQSACFJ?=
 =?us-ascii?Q?aFEVfwYd0JXv+WIwz9ArX/UEnqQHZK27HrrcdHIzGnZIHFcEp/yRcZVSSQyF?=
 =?us-ascii?Q?XWhcVuJx0PTCP3B5j0UNkJ2OVnCzgj13wsDZlcmHOnZZWVMCXZ1DLkwWGAaV?=
 =?us-ascii?Q?0YAPh2K3Y7rjZKFT8SFEQF0QjLeBsGkZLS1yAjclZh3aVzhQH+hEAoDilxZO?=
 =?us-ascii?Q?HgSteEUYBD1xVZhy7gHrfFgi9uh5P5koO9rGhE0BIfGCnVG0wS7Yg01pF0m7?=
 =?us-ascii?Q?gjGdfmJjp1rzs0Rc9bhlxLOQPA+pWDm9RTkvvxaiWbQJ7aJuWWv2QKO6CPpJ?=
 =?us-ascii?Q?ah16O+ZERnuxe7HneNgFbFIDjd/s+D7vLPtrnNNY/igbpvdd8faFrfyhkeO6?=
 =?us-ascii?Q?LXZFP8Uxooo1YgCugB303/y4638OIdPR5vlFzH8XGzaK/863mlXYDGVrcJZW?=
 =?us-ascii?Q?2I6hwqoM3j69oLmkH2gtzgyvm+DK30xz1k4M3isfkvN4cWfWdPPLxEFiJl1j?=
 =?us-ascii?Q?m/4ZlN44oBWMLMZk3EKLbyGQ/KzgfNQDzhOM0VPESPuSkFqMw6IITw70XEBT?=
 =?us-ascii?Q?lM08KEn5Qq1e08HJaCny+b7CQIhnvaf1lOakmF76NIahG3Xbd8vnIFv/nG88?=
 =?us-ascii?Q?Utf48ljNfGBFt+bbQWAeGI/1anHwuNJa+h5bRxiF/aFkMRfv60q6tG9elpTa?=
 =?us-ascii?Q?5sxx3R1ed4u2zC8tWhsvww=3D?=
X-Microsoft-Antispam-Message-Info: 5JDbOr/XFMNY7oncQtTSa2WJkmQKOMAo1cZBAPQ4R7kgcvBQfdCo8eTgl/sz2fniYclwMJBxUtlFN/pcvRON6ngWb0xuJwu4/bepY64eRtimHOnLP8II57n0KCF8nlb90a6YHG58PekoU2Fx/m8acq4hWzOSyAQOPqzEGVGqAMh5L3C1441mUIDHkB8FB+hxcbPbEaSnLahshWBJR6fAB3VIwAqtRguWen7mSJHS0u2WJBVhyMiqr1uhIvfVU2/LNOlUBvbHMFFWDludJ5jR7vlSMBS2JC78fIc+bnINCCYlXf7XW/MaguNE5gMo2VfsbR36Qz5HjfBFaVXgkCMOFM+BjHqIXL9xXX2NmPxMYWY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;6:7dOKaRwDCpgkY3dk7I+A+1CxdphclmGplU5gIkPORXl5f4JeF+/2FqREaowQHkfjDLxU4IKSYI/vnuh4QuqLi1b2x5jUEozo+o+WlX3Ppmn8wpNEoofeSHqjNDc28u0fLYXnSn0OSsGxkbRZUzvN9kNN3Fw9203dMn/MHLV4XuGtby1YBO0RNxJ8S1Nsjwpg8cXXx8glT86TUfeT6us6OM/ISAxpx9EyJ2TkRid4pNhA4fIRngbkSTo81QWgAwREUQ4uZnlSdJX5WXzV/CsAAplJRP2iO8RWQ7wdpcWWKqTCNtHWUMPsKNrWwMmOV1bZOUShuQJNbp4tWca8Rq6685Sgo6jQRAzxnAa9IfRqWKrpfPYwlKtS79jhQjXcTDpiQ61sRkUNsHo7vdu9itkHbsyIzv9kr9MbLNBgHy3z/ITQjMrqMdedmTrocTHbQXxHLsJAlopKN3pmEgsR5jH9OA==;5:xj205FDrCp/bzu1ajp3KxZK2CorUsbNQbaW0I/AnuV27JBgfI4TFdP5lfB9wXVx8odgVg2+uviWxLMqouy+LIkbNWOvRsRwDfW0vqHQB+prGmhbkFEVMEz+xzFSBbw5VsdgCBsBY/8uY5emevaL5ZFNiRml+mlu8MsL0YplkRKs=;7:JWUgjwRUXwsN24b4yEKNmRxW5590yHQ/apkfzyp3pkmEUuLNPA274Cy/lz0BYUGTP1/Fud6vEeNLtAkyx3ePVWg/03lw6P1lGPnrD3ZcRWgdHT/Dt8Vsp7WaL7uz+2uRN+b0XYRXLQHn9L6xALsYe4X+JI/ycALfQOEuCLmJm+mvldN1ljVWxqI+JD9N7f3Emi7mibrAg0nKVkzQPjccbVv7zEZRXW3HJUYUM80SgHpZo6cE6yphQ1+pXyMPVIu4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:Ktd1YW/9aIYy0onUzyttvS1PLcfvTXQzXOb412o0q/VWfNoaobX8JmrDNg/VzwNEUvpG0lbPXHq6KtKyPCYTtuvBPaqAYu0l5m6cmI0hpSmvUSqy3TwjE3jq5IBOBMTEscj3WgpTujNKGhPWCKDB+a7VOQDLQn9THNt5WgtNITw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 18:54:59.2873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0176a3d-a056-4bea-8910-08d5ec16cc51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0172
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:44:07AM +0200, Vlastimil Babka wrote:
> On 07/02/2018 06:52 PM, Roman Gushchin wrote:
> > On Sat, Jun 30, 2018 at 12:09:27PM +0200, Vlastimil Babka wrote:
> >> On 06/29/2018 11:12 PM, Roman Gushchin wrote:
> >>>>
> >>>> The vmstat counter NR_INDIRECTLY_RECLAIMABLE_BYTES was introduced by commit
> >>>> eb59254608bc ("mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES") with the goal of
> >>>> accounting objects that can be reclaimed, but cannot be allocated via a
> >>>> SLAB_RECLAIM_ACCOUNT cache. This is now possible via kmalloc() with
> >>>> __GFP_RECLAIMABLE flag, and the dcache external names user is converted.
> >>>>
> >>>> The counter is however still useful for accounting direct page allocations
> >>>> (i.e. not slab) with a shrinker, such as the ION page pool. So keep it, and:
> >>>
> >>> Btw, it looks like I've another example of usefulness of this counter:
> >>> dynamic per-cpu data.
> >>
> >> Hmm, but are those reclaimable? Most likely not in general? Do you have
> >> examples that are?
> > 
> > If these per-cpu data is something like per-cpu refcounters,
> > which are using to manage reclaimable objects (e.g. cgroup css objects).
> > Of course, they are not always reclaimable, but in certain states.
> 
> BTW, seems you seem interested, could you provide some more formal
> review as well? Others too. We don't need to cover all use cases
> immediately, when the patchset is apparently stalled due to lack of
> review. Thanks!

Sure!

The patchset looks sane at a first glance, but I need some time
to dig deeper. Is v2 the final version?

Thanks!
