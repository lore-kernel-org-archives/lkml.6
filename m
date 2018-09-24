Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B4DC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA7520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="lw3P7u1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA7520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIYFxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:53:44 -0400
Received: from mail-bn3nam01on0048.outbound.protection.outlook.com ([104.47.33.48]:28128
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeIYFxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqGLhZussBWo4zh4YezlRlyFlEu2AE7QGR/bQANAio4=;
 b=lw3P7u1l6sOGs4xcG0R4O8IxwKlPhQFhf40pnePC7E7lh63pauVQcNA5hKdpWylQLJbnTlAsJauAwJWSJclLlKCCbBBk1Kd+VnEZLXO1iTdEFAsyQKFjRmZ45yjVTxxEQsa8xU+8eatTk22asVsQpiggjo1FASxVZcSBRVqUrTY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (95.104.175.50) by
 BN7PR07MB4371.namprd07.prod.outlook.com (2603:10b6:406:b5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 23:48:53 +0000
Date:   Tue, 25 Sep 2018 02:48:43 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix COW faults after mlock()
Message-ID: <20180924234843.GA23726@yury-thinkpad>
References: <20180924130852.12996-1-ynorov@caviumnetworks.com>
 <20180924212246.vmmsmgd5qw6xkfwh@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924212246.vmmsmgd5qw6xkfwh@kshutemo-mobl1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [95.104.175.50]
X-ClientProxiedBy: HE1PR0301CA0015.eurprd03.prod.outlook.com
 (2603:10a6:3:76::25) To BN7PR07MB4371.namprd07.prod.outlook.com
 (2603:10b6:406:b5::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 027f355b-fc43-4ca3-8bd5-08d62278495a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4371;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;3:yuZMIRdAYxEQhzBuCDkHjVpW8PxRr2aI0dnSAvXlkqBA0wYg0Yva/PccnJjmdTJfGZ9Cye3pcTqkmR2YK7TBWrDB7Z48hpypmmf6DLBw8cJge1CMrkyTQ8Gs3gX24gTh53YOv32OyzfwY/xkTe2JlTqWJ9kaR1/ghZj3T2ua6jJ9eQLfRBGYvpaHOCkVzVU5H5hvY2jBsbjA7VbP7DY8lv71OdqR3IUm/w636gx8V6ZS4I2xjbixd6HluEmmeuWC;25:9dcUO/X55lDpEqNgfxoMBDLxdBZQ+dZzLgX/cOVft+SbeYw4kGrjFos5ArrJwZUry68MVS0jh1IAvGo55riY7c8vzSxphVGVgb3we/Wdx7wRJUZjU7NyliUJ+SzpOJXUAaI6+P/KoekkcAR6fiMdTAggdrVB6p6WFFKM5RPXoG5Zwkl8ncxqE9AQiq+uAkuq2HNoM9LRvLG3PEbWff+NtdeoU9ONWWjoHF0Q9/CO0vzhXXddxEPqpf05y5I8t1byIRjepfIdHeHubRUlHqgG1eGx9MzpPOv+N2vWn5lifziUvtiHstrAfKNyB0lMEjyUhwkfbZdf0PpTDbYobfLltg==;31:U9RrPVTka9Cg8R1qXyLgUe3yQuIN+8NvCziZ2+CVXMci3tYTphdk/RgAONHmiGXAEJ5VSW2UlKEjZ544sIaZxL3rUIylWW7k1r3w4sCNzJxTZhfLAscTR2jwyrEYwLknqC7yT7YVT6ta/mKGnh1qhBuMJ+iqbFrYXHGRRBgOnbGeKl5ZtuHsk5FmmE6Dv89klAdDgNGF5HuunkElwmEvG95yPTEsLr1CIjrgA4U4RFM=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4371:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;20:7Svod1lFwRYji1ZO9txaTeIp95DzsehwK5G/jHEd6RUmpXJOjrGK6HdTaLRui7GSV3+qa4NiwfuZo70d4VG0HU07GMjW7sJ+TAsSJGUxu+rLcDBPr+6gdfZplyh4yBSb8stf7s9aV9N1X9bqNq0PqTJoxAyu24+m5wuoMuOb8adPaQnZtlMzNQOYAeLYIBVDgavcQGUbg271MazIFkhAPZBd99xQu0RaU2GWeikl5PXbUuoyWE3P7F0uBuVIZYkSRWbUELVBmLkdnRnYdqud1VFsZosBLmqB2TEt83mGPBWax7tNz5aVfH1rE2cWd5NucoPYNxnyOLW8+8lmTKUnEYXOMEV6/aUrEei1OvwGAGHHg30aDq8Ym7lDnrEo2pxMbzd9FldD8K0ejAB3kQxB2l3o5TnnOi5hIvHT6Hg2RILvUjqzZj2hPEKTDPef5dJms2mMFjNR2VWlC5vb5Z2trkUqhTyoWwsz04EKRA3LBUf2V4tOrxe+C7fJKStT5OmU1QfK/jpilzL/KL7A135w3OevOieVlQIld9LJVisA0HTIxRSFk+B5KhR0H5hgR7JPgs/TAmADTBO+qG3xoe1A/mT7tK4GMh14i4Z7BX/fzV8=;4:aH4sxSAEFInWYjp0dEye4fH6jXqnk5xBqfmY3i4KsNKDDc2zBVIufvHlwHz5fF+bid8aoXls38qcRr8/0VqCZGklbxGSSV1mfljB/MPNGNRb3fXGH6c7WBkr9vdMLhwwIb4cHY7rB82WVTJytJpQRfZFpFU7V6DIzqw1nx9ztW6lgIyIVAICiOKRtT8GgbKEOhT1iy95yV0cSuNX69fCGXhWw/obFQ9FX2XPUMYLuVl/32HM2pgDRLcxZGQdlD6RQA2Xlta9XDiYfQ/38c1cF79pfuGnO+KHzpTvQLgn4wulvuvfToydfp14Nv86H/VI
X-Microsoft-Antispam-PRVS: <BN7PR07MB4371CEAF43D31897148CE202E3170@BN7PR07MB4371.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(3002001)(149066)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN7PR07MB4371;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4371;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(9686003)(53936002)(6486002)(229853002)(305945005)(26005)(7416002)(2906002)(386003)(8936002)(66066001)(7736002)(42882007)(33716001)(14444005)(6116002)(3846002)(1076002)(23726003)(68736007)(8676002)(72206003)(4326008)(5660300001)(478600001)(316002)(6496006)(486006)(54906003)(50466002)(16586007)(446003)(6246003)(956004)(476003)(52116002)(11346002)(33896004)(106356001)(186003)(81166006)(81156014)(47776003)(76176011)(58126008)(16526019)(76506005)(6916009)(6666003)(25786009)(105586002)(33656002)(97736004)(39060400002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4371;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4371;23:eVO/+WYYZYgFHPxeRr9FF/2cJS1VGWFABYOw4IFwm?=
 =?us-ascii?Q?zCcQq9Br309euMuDyT4Clr8A4Rc/28gwY2kkQwQb2KKos7vnIjaTP7S1/TDu?=
 =?us-ascii?Q?GpoiVR+eMF1uAXqVYZRKbh0OK6tWUYnOQrE61RfiUbglHs8QjsdXVOi6iOUp?=
 =?us-ascii?Q?Udld0eRXnsGZ56sJJxTChsZjmme2687keALGY9oVWhyf2tP2AKd9lZr+eWFo?=
 =?us-ascii?Q?e0SFPFBmmue0ywW0YryGUlt0V0di1OsiuNFP5p0tjBTKwKSNi9VL7pM7phGJ?=
 =?us-ascii?Q?qBW9dyy44J83MCCbwTnVhg6K7y56aZVhwGnAdCQGk1gIctKGFLmXaJ3wbqxx?=
 =?us-ascii?Q?6n5AcqcGfPAsZu6rBxM1166algvCKYhAwfEigjopx1XfmCjgi8QEoSWCcm5n?=
 =?us-ascii?Q?D1zlRMR2nFAVQpITi6G13xWU72tu0+Q+5DkYi7xwMzz+TMUfS/pVQRb0Qqse?=
 =?us-ascii?Q?VBeqASg0srBO9clpu+85TnfVqpnJEJYkN29/M6AxW+BgVWBVa/39EqP3o2sH?=
 =?us-ascii?Q?9SFCEJiSoFa6Yl4lbaQeT7vka1phZi7UQsCkxbTUeILIvD4WfgJk6X1ed3fd?=
 =?us-ascii?Q?GUliIoMJmuYGrJku0OA1Q6lsQW3x3kiaudjQTOOKSq3rEPQHK90HILihAA4a?=
 =?us-ascii?Q?TQemYZOyTBxWwIDS9aPDNOX3P6vd/y6ugkp3RWJMap0l3AFXs4sLAnwa9ILk?=
 =?us-ascii?Q?VrNv11Ohwl2udRc3M6kb4ehkikg7tQzV6v8ARI/XQSFKfJ1uzu9Tpr9N5zIc?=
 =?us-ascii?Q?Oyw/EN/2QA6uAsIYX+k6iX+uEuQkLI8Lj26obsyT0SOWF+Qr1o7UFGoOvCUD?=
 =?us-ascii?Q?EVyRsT+udwaRWPs9Vq926AX7m4wK0tayMb4fIVFyORZ+/JMLX1+G27gnwW+q?=
 =?us-ascii?Q?Qxk+jKOx9Yfu/jkPOJ/lWzYPSCm4VCc7tIHHN1BmrDIs2QNfO03fLxrctOiD?=
 =?us-ascii?Q?vUglOrRJDNGQBN4KdQuOvbKzGXv8E5QRmllMyBC/pvCepi2aq5f8BrNvi7pX?=
 =?us-ascii?Q?GUh/N6ch2A0XehW2qOqabDCO0fN1S56Cf31rkaUtApnmgREdsf3shfAqThOC?=
 =?us-ascii?Q?mTckHGb66wDkqnFuGlwg1L0xpA+2dSWE4zbbNYp/xHFMikT2pS1b/+UgGGkK?=
 =?us-ascii?Q?WML+5mcEBdpp0+np69pEcVKYKMaNffql4Ke9ZSgTyhRm90co8rNw5BjxMb44?=
 =?us-ascii?Q?QLgdmnCfm3UnRHjGe3/lxi1Y4f5LaKyNo8msL7s2IhCdQbkQS0p6oDODlHsd?=
 =?us-ascii?Q?eNvoAGOI95m14We2EhQhzTtNDguv2ICnTy2CsITLuzgnMx7Vj0YGp25e7x8F?=
 =?us-ascii?Q?Bm94SD5AAW4UCgV2MFl+4+yDlC8IeRc9iiSNTE5/MsKwP2FGZBxqfESSi6ME?=
 =?us-ascii?Q?T1SHQxs9l/UDpap0cS5JuLsEaumXQ85m9vb/tsWTv7hy94ty/kMZ9eqxWFtl?=
 =?us-ascii?Q?dzrnC89cQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: SV0VMxv+BVq1OGrEXzU6vnVpoVERQKca3toNYC9X/a1tLxLHE0UD281Ps+ImOycy11mKBiq9zj+MbtIq1Red7E5OhN9zxhUyn0qcbhbZN4GyIQ9GlKrz3WTkCG3kvS9ggdRsGJLKX6DPqRXoYIccqQj/lfXb8QL/R3hVXwPu5KS5aChSHc2T/MFxkACPKTPKi/sFvRLtXC+aOZbwYmu/RMuAmqO1ueIwTHA/WZiRLKL/3ksQeErNB/Vg86AiMV6/x/2ORsKPei66TFBICx3jBe02QcKye3yP2A1aZQfCLn/14MkPWwU6JQqC7nTc7In2yo9kCB8rbeV9WrW1QBz89kOM4SN0zG+qSwACdl23QBk=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;6:e8FKH7mOvjDkwSTlZZLbZ1tqemLzPnNRAKbTuMrSdtj8dVkhAGNloBxEzQxmuLpzb/Ik8SpuwIq+mbeW70cEVwVWXS36t4oMcndVenG3EOxqv41HTwp2Zb37IOG0Zvh3Gfko4FR21LmxPC6uveWZmL0TxS8twAEcx0m24h+upgyEgKzb9AcRSGrLBUAs3QKbZ3KnUVhdgG6v4jTkJRsMzHY2DuavdwmgF1SS2ZKBd+fO/fMF2wuJr1Qvl5/eKT0GtHWAbwSgfzOVMlDome6iiNdUr4dGb16rq36wIek06LrJfuVQSjdsn6B9MsoHHn2K1FwXPLSfhcysSZPPd8K67pQcSniNrfr32LbHWRCfBMAQM44IbvFcEBzoEHrMmOGvXiENp9FidPS8YSjqzq8YCVugE80F1DzdkfgFcmKonDWDQy4Btq64ohYWg3qWN/ULP+6TyBt+H9CsfsoGTfPAVw==;5:vTbwmvZXq1vDriYaam4ouTH+KvVjnC0tAkOqsMd6NGzPpeIULLUEcUIt/qDYlCV64OSjTS4H/m9evY2DZmxvf2p+1PDPOxuVjm7gtNAJPWQ7Md0IJVBtteHraorvfaV+xXo63CE9XOw+Q5NbwhLsrIrYxtNv1rLXj/ZLMj7fd10=;7:LzpCdrx1AJ95fkxe5SViIZJkwmq3Z9Q6jioMhSwOhfd2TS6NKdJVdoVjQqBT8gA3bqvwJoMHi3rUE5e3QP+6jUj2dwyVgW4a9gpiDq/Rsp1hElQG9lCzKirqZqP951IW7koYAIAs4L96Q8KIywFjLMpxxezjtO66Sv3i7C6wAsc5PHdqkQxMpHTOgM9rLGfs6Gj9iPNgoHlqdEUmCz6bXAKyJtNJs+au3ZlMdEgIVvtfMp2rsQgYa/EG6RVCIGIe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 23:48:53.7131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027f355b-fc43-4ca3-8bd5-08d62278495a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:22:47AM +0300, Kirill A. Shutemov wrote:
> External Email
> 
> On Mon, Sep 24, 2018 at 04:08:52PM +0300, Yury Norov wrote:
> > After mlock() on newly mmap()ed shared memory I observe page faults.
> >
> > The problem is that populate_vma_page_range() doesn't set FOLL_WRITE
> > flag for writable shared memory in mlock() path, arguing that like:
> > /*
> >  * We want to touch writable mappings with a write fault in order
> >  * to break COW, except for shared mappings because these don't COW
> >  * and we would not want to dirty them for nothing.
> >  */
> >
> > But they are actually COWed. The most straightforward way to avoid it
> > is to set FOLL_WRITE flag for shared mappings as well as for private ones.
> 
> Huh? How do shared mapping get CoWed?
> 
> In this context CoW means to create a private copy of the  page for the
> process. It only makes sense for private mappings as all pages in shared
> mappings do not belong to the process.
> 
> Shared mappings will still get faults, but a bit later -- after the page
> is written back to disc, the page get clear and write protected to catch
> the next write access.
> 
> Noticeable exception is tmpfs/shmem. These pages do not belong to normal
> write back process. But the code path is used for other filesystems as
> well.
> 
> Therefore, NAK. You only create unneeded write back traffic.

Hi Kirill,

(My first reaction was exactly like yours indeed, but) on my real
system (Cavium OcteonTX2), and on my qemu simulation I can reproduce
the same behavior: just mlock()ed memory causes faults. That faults
happen because page is mapped to the process as read-only, while
underlying VMA is read-write. So faults get resolved well by just
setting write access to the page.

Maybe I use term COW wrongly here, but this is how faultin_page()
works, and it sets FOLL_COW bit before return (which is ignored 
on upper level).

I realize that proper fix may be more complex, and if so I'll
thankfully take it and drop this patch from my tree, but this is
all that I have so far to address the problem.

The user code below is reproducer. 

Thanks,
Yury

        int i, ret, len = getpagesize() * 1000;
        char tmpfile[] = "/tmp/my_tmp-XXXXXX";
        int fd = mkstemp(tmpfile);

        ret = ftruncate(fd, len);
        if (ret) {
                printf("Failed to ftruncate: %d\n", errno);
                goto out;
        }

        ptr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
        if (ptr == MAP_FAILED) {
                printf("Failed to mmap memory: %d\n", errno);
                goto out;
        }

        ret = mlock(ptr, len);
        if (ret) {
                printf("Failed to mlock: %d\n", errno);
                goto out;
        }

        printf("Touch...\n");

        for (i = 0; i < len; i++)
                ptr[i] = (char) i; /* Faults here. */

        printf("\t... done\n");
out:
        close(fd);
        unlink(tmpfile);
