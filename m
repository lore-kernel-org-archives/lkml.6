Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C859C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158B12087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vDgHsprl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158B12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJEALu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:11:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeJEALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:11:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w94H9Tbo043457;
        Thu, 4 Oct 2018 17:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=oo7jFiHcdzxADLMPn/9lwDjBHVOhycYpZbjFcA/Avc4=;
 b=vDgHsprllu3IQ3mPujLpmdIZE5+iFORsdrOcjESj7g+8Txk4x599g0yOuJcC+hs1BXtT
 YuOykJKjdnVpGL8iphWcRNVuxWVjGWye+8HBzJ/25q9OCLKbz/jGn+QRK5kWRMPHNX1j
 g3YP/OtKjIbLQ58xjl4woexGhMhDv7H7euSbnRSRxF6bFubsrEp57pBHRpgIM/Wzkybb
 38QfFU6/6DM+nhnG4RIjtDl5jboO6HZt2qAQfCm+8AVeub7WYh5FqrUBEC6Y9p461YuL
 e6j0TwnLPG4JJQAyKYPbcEdB3gttYZIJsS1g/W0OESmDnPKonBhZx8/TbB2X3LGCXcoN /A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mt0tu5rbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Oct 2018 17:17:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w94HHYGi002704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Oct 2018 17:17:34 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w94HHX20010944;
        Thu, 4 Oct 2018 17:17:33 GMT
Received: from anastasis.us.oracle.com (/10.152.36.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Oct 2018 17:17:33 +0000
To:     "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH 0/1] drivers/char/mem.c: Disable encryption bit in page tables
 for MMIO access
Message-ID: <671c6651-71b3-0e0d-8e87-191ca14fed50@oracle.com>
Date:   Thu, 4 Oct 2018 13:17:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9036 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=615
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810040159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD based systems, mmap'ing a PCI MMIO region does not return proper
values. This is because the mmap_mem function does not consider the fact
that IO regions are not to be encrypted. 

In the failing kernel, here's the output  --

[root@foo]# ./memaccess 0xd0000000 -t pmem -l 32
0    (0   ) : ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10   (16  ) : ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 


I instrumented the kernel to print out the PTE value --

Jun 20 11:46:35 bur-e1-2l-303 kernel: pfn = 0xfffffff80f0866b2, vma->pgoff = 0xd
0000, flags = 0x5044471,  prot = 0x8000800000000025
Jun 20 11:46:35 bur-e1-2l-303 kernel: pte = 0x80008000d0000235, pfn  = 0xd0000

Note that 0x8000800000000025 -- bit 47 is set. It should not be set for a 
MMIO region. 

When I disable memory encryption (mem_encrypt=off command line), things work
as they should.



[root@foo]# ./memaccess 0xd0000000 -t pmem -l 32
0    (0   ) : 20 00 00 01 40 08 00 04 f1 00 00 14 0a 00 ff 07 
10   (16  ) : 65 f6 70 02 c0 05 00 00 a0 04 00 00 0b 00 00 00 



James Puthukattukaran(1):
  drivers/char/mem.c: Disable encryption bit in page tables for MMIO
    access

 drivers/char/mem.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
