Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE20C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E226220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LIU7yLn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E226220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeIYPfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:35:45 -0400
Received: from mail-eopbgr10105.outbound.protection.outlook.com ([40.107.1.105]:35055
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeIYPfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D683WOacdpenn093NLLJ5+N06mbotbKaLCF7DeyMr5g=;
 b=LIU7yLn4t2cYJOD0DzEL1Tzmqz8sijJWv1a/9g5cRwdniuclFMi66Bz+OYADILgKPren7zfOquam90wIJvsrY+21n+4C11DaYKTcFS01oSSqjpVPJjv0v51f+f+tICZ3vaoW8wQ9llfatM44RiRQ5+0XWWQIFD4z6czj21edo4s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2027.eurprd08.prod.outlook.com (2603:10a6:3:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Tue, 25 Sep 2018 09:28:59 +0000
Subject: [PATCH] fuse: Fix use-after-free in fuse_dev_do_read()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu,
        syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Tue, 25 Sep 2018 12:28:55 +0300
Message-ID: <153786771676.20496.9149001582398031266.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:803:14::20) To HE1PR0801MB2027.eurprd08.prod.outlook.com
 (2603:10a6:3:50::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67f36c14-4d1e-4335-bb8b-08d622c95344
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2027;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;3:/7cLfENWg7e1CXCakC/+ddM/Y5+woPYbfX4PK2rFxDcckT9UgUVUvqefVHWdwPCvyDJjqXlqXufk/CV4yD2L1UPCO0kxTJQJCcHJw2ipRenFdu5NCiGNmWDqzptIl+MkROJKYG4xK9o8208Cf3lSsxannAuh8ylGRb1RipHXp2dr4blHO9MUsRJOHq3PjQaeK3vE1YQRGn72M3WSQTvF2ZklVIQ+fYkeRf4n1o14d5G2Ggg9x4G54996SqzFNFft;25:Crjyhgd01CPa9cIKUNIjqRxjxdQxNJbo3W1uKaBiQAjvYzyXxHmsqE7a2YX+fGh18n6yK9m0dXIDqX1OARHFSEtNRM6Fof4I2uIWETTaGCWkeu9CXQmQOUxYcM7gIJfHirTWsIp5CUtNhEa80XZYsnEjKISnlpVOV9SkL1ortJN+8wNm6sQ2z8WBQetxfeymbeNe6fAg0JkOSnTQPCbKLOPmxU3lQRtws6/vqb4kLBAdSNQ4MTWiJIuI0zJ2381YfMFXGVv3WLbICmHkiZ5c64zaJWrddm37WEa/7Mv9LKGG17VEOvuubIL/v0rBl2VQ35Q9y2ivzlSmqH1gu1tOew==;31:PkzwzwNesobmOf/HmGMZPP0BXY9BdXQ7HHM/fPIuT3SD2cKLwIBzSxTEZc4LrkxIqwjfV7QrwpRRpu8d2rixebCUcz/lhr4Ry9+YIMNmz/nVYWE6oMTrm+eyXZ/rlYAMpMI7pARzbBhLdGp636m+H82Aj/9chCTPK1t453c6s0Hn/1d7FDSmEaggNuE/11eIYUq1lO0jKP3w/AXSt/8OWyUsgdHkqmmvJFyAQDzJ4m8=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2027:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:dzW3uiiVIhPezCkDeQdDh9b1c6wBMhhR6FckhUuAqvxe0dc2qake1gUpga4prfIYI96LcGtZiZfsvOlIt6RSzI2XxTYeRGN5G0OPx2T5vgj1z+D7e5X9jA4sIEVYJWHEi2kYwSDKctbNelL8M0MU1GFf4Kdi2+0YsDDn1kHJiPuPVWb5RAE9244ylcmFWGedz+XwY82g2xYkIEm/BNhItaixCHEXikzomnmgpjWMP9GUi+kQwd9KkTKGcxd5HZezQAAoA6gLO7brWfm3qLz5WEuOwL+hFnuEF00Slm2i6Wvsq8o2aDjQT14mddyDf5ufuq3HKxvroe/LWSGCcH4Y4vfRGkLt/P/xFwlzhK13eoLfYunb0+Gaf+sNsQ8iz6LaQbnyzyWcrl0jOTTx0IlMXq4YT412REylcLMyWgO0Tl734zPEv39oYOzdRNC/iob3HjjyZxIfvMgmCcn29DgoSU9JBIp2zt17UTEOwtAZDHNtvn1xt18wx4NnN4Ge1BAe;4:VCkA+KA0tkuLcuC2O+ctwF8Mw7x/mJESm5KRXPMvXKDh4P7EkrTe9DE5Dfj/IGHED6qsBF935upaKSAbB651bEjfgUMwd8lse1x/pBt1EMgFCyGCznhvnFF3ukTKDkU/KJHhW60gCT5xD3Ml1CHGDoR6fXMtTWtcN/nY2iiPu9Imtd28kaRFtp66T0uNfoMe40FYOgqTgZjdG3ZRYw8cWgXiR1N0gn3Uc4jA1NTlJsmjP2yx0+oNO0qCKc6//L3H/TTMAPtGkoJIsaTVALy7mQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2027B2EE45890782941AEDA6CD160@HE1PR0801MB2027.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:HE1PR0801MB2027;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2027;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(7696005)(5660300001)(6666003)(3846002)(386003)(33896004)(52116002)(26005)(486006)(53936002)(476003)(55016002)(305945005)(16526019)(186003)(1857600001)(61506002)(8936002)(9686003)(6116002)(81166006)(81156014)(68736007)(2486003)(23676004)(58126008)(230700001)(956004)(6506007)(50466002)(25786009)(7736002)(105586002)(106356001)(2906002)(103116003)(97736004)(14444005)(8676002)(478600001)(316002)(47776003)(66066001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2027;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjc7MjM6cUs1dXd4S1BnbCs5NTVJcUcyQm5mR2FH?=
 =?utf-8?B?aVg2bVB1Z3AxUzNQaXVhU2lBaWFWQWpoanpHVXBqSHBTOVNsNmhzVjhpVHZh?=
 =?utf-8?B?azZkOGpHS0kyL1lLcWxWMVJsL1JSa052bCtybnh6NWxvMVREQ3VRd2xzMGk1?=
 =?utf-8?B?aUhNT256SHBMY0ltRUJzUTlQOUx4OGdzK2JaTGhoRWdma0VHWCswbldxL2Iz?=
 =?utf-8?B?SjFHZnBDdDhEdFM1d2tWNDlsL0VYVWlxL3ZYbGhEM0dxTHE0bytLVkN0RlMy?=
 =?utf-8?B?TGlIQTE2ajlrQU9GNjg4OHdPYjNWaEZjV2UydzZjQXUzY2NUV09lVitJMXQx?=
 =?utf-8?B?QzNtVGNuUTBhUmpyc25nSE9IczRuU0M5NVJrS2JmU0JPTUNJLzZGOVM0NDM0?=
 =?utf-8?B?SVVvYncxemVhSVMxOGRuLzArUGUyVkVLZ1NkZWl4R3k5ZDh6Qzl5TnRvWHpO?=
 =?utf-8?B?SU8rOEJ6RStDY25XNURRMlVFRERYaWtUT3pGbXBCbTFRVyt0OFZOak1FT0hh?=
 =?utf-8?B?a0w4N245Q3FMTXE1bDRmTTJVSjJHWndQZEZGU3FnaHg2UG9mNkZFOFdaYzdH?=
 =?utf-8?B?Z1B0b3RBT0MyMkhSTU9rVkNQYzgvUEdkUENMZVh3eDhjN1k0ZFcxeDMzbHVK?=
 =?utf-8?B?NjRGK0dCNTZJYVovT2hBd3piRGk1VExHcDRWalNqUHdTNU8zUnVpRTBkLzhL?=
 =?utf-8?B?ZkYxQjZoQjE3UHpiZm1WNzc1eElySm9PRGhOUEIvWHBIcWZ2UjZBWkNlK0Ni?=
 =?utf-8?B?dDBqMWhMT090NS9XNEdTMldNM0xGME4zRVdQWkMxMDRhbUdTeUdvR0doaWc0?=
 =?utf-8?B?UVE5R283a1NJWUlsZGk3ZUp2dEZ6SzVDN1VYU3N5elJVM1FnOEU2L0w3dEdz?=
 =?utf-8?B?S0txMEJzaFR5bE5xTkpjNEpNclREOVFPaWpxVm1DS1NCdGtQb0pUQmRldTJK?=
 =?utf-8?B?dXUxUjF4d2JaWU9peGpSV1c0NDE1RVRDZjhvZXdGT2gvUlo4MHBPRVlpalU5?=
 =?utf-8?B?N1Y3VDJCU3RWNWtEZEJLcmN3WW1ZS0YvVFYyZEh5OWc1Rm1lY25JeWhiTmNK?=
 =?utf-8?B?Y2dvTFdFclJsdDVDUk1GLy9Yc21wSVJXNDl2ZjVUcTA5eHZnckxrbGZLMitq?=
 =?utf-8?B?RVp4aDF1dnMyQ2RDcnZvNi9WTS9KMzhabWFVRzFtYUJYZUN4cmVwa3k2TUZD?=
 =?utf-8?B?K0RCeVU1emZQT2QvZWsvNVlXT0tDSkZqNFhucHAzUGV0YlpaQW9wdkZMZGNN?=
 =?utf-8?B?OTgvSHZZYUhxU1l3NXZ3REJrWEhyQ2dQSmFKclFuOFk3em5IOUhNK01NcXgy?=
 =?utf-8?B?djAvUzVNUnBTdkU0bDZjT0NtZ0U3T25vdTFjc2MxOTd5cTVhQWdNOERxRUFm?=
 =?utf-8?B?TlAzZ3RzZ3RDOHd6enBNY1FPTHh0ajNBSXlLWkFWVG9mYXFBZXhac3A2cFYx?=
 =?utf-8?B?L29jZjl4ZE5yZktEbUg1VlAwYkF5cVdiaFMrL09MczJ2eVd0SGs4NzJDd0hP?=
 =?utf-8?B?aHRMN2F6N1dra2o1ZkxkWWhEV2JJV2dtdG9DakhOai9NeWxONU50UFIwSEF2?=
 =?utf-8?B?eHpSQ1RNcGNhKzZVWFlPdk5yeW1TRkt3MFF0aGorME1QSXZLaERicFZLa05i?=
 =?utf-8?Q?s=3D?=
X-Microsoft-Antispam-Message-Info: +d/4FdOXhwSPhbRLAyh2BxsDRkpcDCyz0ff4AC+krmsnRTT8eP1ui2v/+WvREpvMpO54yujgQNqjGTugjwU2mY/aVAfIuVvwN8t3NRKJznAyQqGZsqOVtQoR17jiFdzgObq0Zxv31pendMUf6lzuPzjbfM5B5u4trYu2Xqu1XgnrzvTIgZT9q95QFM1cCw5S4X8/lVEw9s41pjj7eHcuBoj2Bn1+d5Mbe0d3E4jLVpmzTXx93hWY7szzHtrW4GoPFOwdpUMOi++S9YSxtFshg41c7slIxkKxLW0ytVJS5mchEbSh1bgcNa4iXSHiFXTo4JE+um9WIMlWer5rvrOznx7ZH8sS9f+fDvel70uO5yY=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;6:3RQ+8hZ0t1fpN+iTERKidXcoQfyErIw3xWZ/7cQrEBXbSzIEfNTkZM5IURe5h+I/5jxL1QwsbZopLIKvuMJMclmXIgd7Gx8pgZVvA2adiS+0OVJfVpoxEz26WEXIvmhvBJYh78FwCTCNzTFuM0Nu+gCuOQ4Q/BXdFzfjf6gFofg0ORctdw9Jol8/MNcuq/PSXy9AGkCeJ4+ndMFAnhthmtzvOTIgm9X0NUKAUX03gFPPYS6VyL7Xlz+yeakwCX4MtCazIvkfYk2CuS583ZNfS3j0590/db1PlepB7XeELhgS8xmY+M7BEo3Y+sbgII9tY7CqRg/pkgcAuaL4vbus2ZybOK5p5WSDpqTbe1ufpV2pwiO8jBjA5tudl1kyvBdqHQdK0Rw8pux9UFnrjqH6W6Rw8JJ66DD4hr2eBpWmnLOv2e4uPa+gaKPpB4HqZ/7B0WvN/GFiuYtY6Ht9Djh4gg==;5:C2v4w7lkG0ys3jxn1XbEV6gIFG7MKa1NQMyTaawInOzMRJjn6ijcOsLQR6MljRBQZkCS7bUqJI1rRcyfSSNeZZT6CCdXOptEMfaYUFrbQzAKeR/UsMgwSBRphcQFG+03U1lPyFFbsFZ4pe1tpACzqEVc3Mh2pVT+MIlyKlcNAsM=;7:s5CwZVxKsC1VgygZU2kqSTObJOh0cRiwzTk58wXSu59SrP7dwvKHkTArGikjjbZwgwXYyhFwtYaPsbrLCNZ1tJDTF9T8SIMHwBWwjZ2xypO9RtFrr8Tnou0GQzCJBSMLy0qyIk4kSPq6EFRATn18992Cvur4jreogTJwF0ZbW5GZxQJ7xppHZhggPVEKdOH5+hLigAD0DOfd2dCyKPmEkYJ1w4CYwRDKmbsEHBWcSGl/Kr317lnSb+asYqaEts6d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:/w3raT1KKDrmVmeuDiCrpEkfIDLuXrnoNLKdRFLGe9zTSdZvcchA+sRg0r6B7UPbzybgy/rJb5pZ4K7+yPKeTL81KQBtxVh15atS9ThRGC41G3Y46aX2cWSU+i17NpdlDrdZ39Eb75g3oww0BaR7eKYorfTT813zJ4fbrev1ZwU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:28:59.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f36c14-4d1e-4335-bb8b-08d622c95344
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may pick freed req in this way:

[cpu0]                                              [cpu1]
fuse_dev_do_read()                                  fuse_dev_do_write()
   list_move_tail(&req->list, &fpq->processing);      ...
   spin_unlock(&fpq->lock);                           ...
   ...                                                request_end(fc, req);
   ...                                                  fuse_put_request(fc, req);
   if (test_bit(FR_INTERRUPTED, &req->flags))
         queue_interrupt(fiq, req);

Fix that by keeping req alive till we finish all manipulations.

Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 11ea2c4a38ab..675caed3e655 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1311,12 +1311,14 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		goto out_end;
 	}
 	list_move_tail(&req->list, &fpq->processing);
+	__fuse_get_request(req);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 	if (test_bit(FR_INTERRUPTED, &req->flags))
 		queue_interrupt(fiq, req);
+	fuse_put_request(fc, req);
 
 	return reqsize;
 

