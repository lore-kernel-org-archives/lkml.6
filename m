Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A932502C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hpfq+gTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A932502C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936826AbeF2Pz6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:55:58 -0400
Received: from mail-ve1eur01hn0206.outbound.protection.outlook.com ([104.47.1.206]:14123
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936157AbeF2Pzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1a6CgPLJMcLVai5YeJRUevtU3z0yO7pG7qKOFvsqDA=;
 b=Hpfq+gTgwMr7GQBXpn6KOT7vh4m0Rxq2/OWJHRkrXfpI+bpepvV/IzDGpvJJ3ELS5qRrjelYvdaLWz8mQC6nb1Jr+V1ILcdb5Di/ixgGYwyseO8py79Y116cla4miMQ2kVSG+iW287M5alRJHiIBtdAGa59q41p5P5sL/Buf/nU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1PR0801MB1980.eurprd08.prod.outlook.com (2603:10a6:3:4f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Fri, 29 Jun 2018 15:55:37 +0000
Date:   Fri, 29 Jun 2018 18:55:32 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx
 mapping
Message-ID: <20180629155532.GF15656@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180628135313.17468-1-vkuznets@redhat.com>
 <20180628135313.17468-3-vkuznets@redhat.com>
 <20180629101134.GA15656@rkaganb.sw.ru>
 <87y3exdh2o.fsf@vitty.brq.redhat.com>
 <20180629111227.GB15656@rkaganb.sw.ru>
 <87tvplddrr.fsf@vitty.brq.redhat.com>
 <20180629125216.GC15656@rkaganb.sw.ru>
 <87h8lld9hl.fsf@vitty.brq.redhat.com>
 <20180629143212.GD15656@rkaganb.sw.ru>
 <878t6xd37f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t6xd37f.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:7:28::17) To HE1PR0801MB1980.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ee3cc16-dbba-48b8-3ee4-08d5ddd8c262
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;3:51fESqDyRLSxrcftJxJxTRwRKzS6n+pbLsYugjaY0NO0QkaoEm1J5w2QGsD/don/ETYQDtw3v9PUPYue9qNhlvLbXyUTUFOFwhzlstRiuzRo5QRD1fbEh1mMVTUHfOgMKbhjLkABa4YgLEWMoiy0NTL15SgBGCtZRIYvnCfDVt5/fZMpp1jhk52hCnDvXPUmysNYENW4jzJbPW4fa/a7BJYEMNNuSDfAv4fMzP3qieFZ/RMMgceU2Mv8tO0CC3K4;25:lCOD2dB4ffImWfkum7Iu8Vw0aCw/a7tyBANPyw2YtyANdgpkHGW6Rh3HFby4p5Ua4JiFH5ayNbMWnsOukaLTfzskcPfqFjdiKDWSnIJ27AjGL3AL3nB8zSMl1pu/8gS3ACntYjJCUaZE2kLUja5KXk0/GwfJWgmEH0alfTRHXUgGzB38P4dUfu8KVvTLp1csCzSY2BK/yiiXvrcTOIx6I4IH4+XeOxAKwGNgcwQFQClagU5zYYP5ZfNFrT+VA+ymvSAoVVR5+EoF229k1wXbs1NbHgUgXzSEGBc4oM3ZqUXzdYfChG6nUgV6xBDCPB7GcEJGaJrMsKrnKSMzrJr7aw==;31:7z0QKc+GoV5zM27dDmV5m6HTUfdLUl1D7qMwoPP8uspTSoCeCIH1znB9+0WDb22oTVZUsPMCFkJPbT+2PosyzOiSYseCoQik2I/o5kZQi5qsxaovNc1XQ9C/62EwqIcd8pzEimwbpbS+50hkD7Zr1loP5XyJwV8pxa6BRnPig/xW13Jq/pLgMDRlP3zCash5jSfRKj0ez7aPkcxr3601muEWy+4egJfwR5WGZbANinU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1980:|HE1PR0801MB1980:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:ZLJu7OXSG6INA5MghXCmIn590Vp8UQh1nUIAOMwvfukMIuzGZ9J7rDmpM5U9La4yJIOLkj3bo6vF5K0d/oL3oaYuvuJ1GAb8QEXqLceOZX3B2OcVUprxMhsRvwCuay9XQEZsyd3Z3k3PUYsNhWc69V1JcayuUcTfBLpg4SvWiha89U+GhCwzVAERiqJhv/hLkGFEOGWzkpFmUlYZfVYURJrKmH3o6vQuLAwd00vh93d+wBccodOdr77R5m/Gaf/ZG6oma53PmZEA6kSe7mS7nFJjZD/Zf0L5wOEx6YtgvqpvwT7UnC9pCCy5QzcUrE0Pw8e2IRNBrlzRt2Aj71HRknnhA7xHBBPtEV2kHoK8dI4o+sqvyHizxIOphV0sdvIcgMdcUr7vMovtLgE5ntwRhtpukuWyZ59s8EJlJXhSS5ueL/9PIvHoY6P4/txm+D6e1O+BvfF3Znau/dPbTOKhdR01GTKDx8sXxElY47YqRytvz6ew4sIJUmC949K1sCRg;4:mnlmfG/IcFuUTPgTOFYox6Y8Qnc9O7cjsVtL0bX3PCVUcEtFBM4FciSw7/9NIOTJmVl5uyIGNH5v1VkLqbqttrnMMqHB2cMYrYneknpqtx6JhpJ3jIIExm6sPGhAr3VwLsUAUEAFac7AMULo9mVvYgZZ4MJFx98wqthGtSWPlzyDWNG1DyZx6MtzICWuo/8daswLK7CO5KhpNo1QNxn+cmOf9KXLlKa48MXBhrMJG7rTXaKoVYXqiYG26HOxgTLQnGva5QwX6bPxTOrQ4dLXDA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB198083694E74D104DE094454C94E0@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39850400004)(396003)(199004)(189003)(6246003)(6916009)(486006)(11346002)(956004)(6666003)(39060400002)(7736002)(6116002)(476003)(66066001)(3846002)(47776003)(446003)(55016002)(76176011)(7696005)(52116002)(6506007)(386003)(23726003)(33656002)(1076002)(69596002)(229853002)(97736004)(305945005)(105586002)(26005)(106356001)(16586007)(54906003)(16526019)(53936002)(7416002)(58126008)(68736007)(478600001)(8676002)(2906002)(5660300001)(36756003)(53416004)(14444005)(186003)(50466002)(8936002)(81166006)(4326008)(25786009)(81156014)(316002)(9686003)(93886005)(86362001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1980;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1980;23:StydWUCcjUCKFOF5+N0SdW3soay/15UvctfwIeh?=
 =?us-ascii?Q?4uNUYLdJlQAflQdSdsC8CxYDPAkFUyhfWYWA12qyrikOPGPgHSMBvrbgJOPs?=
 =?us-ascii?Q?J/ED4h00w4UjG9qxB/pXQb3IUvxxanSDlwugx9N3hIwzWn8n68ETEEatsKru?=
 =?us-ascii?Q?Dco2xZXcv8u5e7VDLrSEwToE9fXcVn1EMcQhg1lQBsAMPWWfMq0r4myc6Sgd?=
 =?us-ascii?Q?CmowXZVGQ5ZkmzZfLvYLtm5jnEMs89vXv7vFQt2Yv3Ojjg413CBa9t3c3YAG?=
 =?us-ascii?Q?HwZSfwM2xUJPG+uh6JJtf17M6lmfJs4DUHg8mdXPY8nXuoAuBONz5QLm4nO9?=
 =?us-ascii?Q?g2YYR0Wzc6ZHC07nFewMtBaL3pI336TVOXQbEZ66RWbgaGWWqx1z6P6dpkON?=
 =?us-ascii?Q?F/SQm3Dz63qPcjXTwyVofJCJOsnBCu/zYNl2jHgeu7uV+4HKd1sC1IwmUfPX?=
 =?us-ascii?Q?AMV3kMFzdUcdv5MoODrEHW9d/jSflpSBrePgGg2ia0EBOMBAqxgarCy6H/D5?=
 =?us-ascii?Q?GJi9L7innitVQfR5XdfPdwR96Z5VSOhoPGf626172LrZS0RwrCCfzYfutw3d?=
 =?us-ascii?Q?8wcT10SErdDt0jFLnOqYcep/zOmLKW1dex8MvQ+KHJHx79ubW8X5iuj+oZbX?=
 =?us-ascii?Q?z/NVczYhMKyTN+WyEs5V41jbsaOVAEH73+UlbwbHflWyhe+eXXydVOhchKmn?=
 =?us-ascii?Q?X0vguYfnOw1duKyY6yNask5u0iGRmfxivOJgcb92yVCzkepVkvfQHzglJsHc?=
 =?us-ascii?Q?zUPpibGMOBhr9Vin1c6Wifk/qZNLKsQt3n16a1MLZfq77L4iqtHv5dSHShzB?=
 =?us-ascii?Q?vEczV9bJoe7+b/YkpwxjmuRkW4r3in//PnQ9qeFE0M41mBccPdBI6Nhhlp73?=
 =?us-ascii?Q?A69/GzRoassnzkB8CiBC9TMZTicoedBk3nY9qP+D1BtN7MyqEgPzz/+E1vRr?=
 =?us-ascii?Q?QFV0qRGfDKoyuwCM/UcyMNkXhwgt4auRRZSGcOfDf3x7opUrQopxeUwF95SF?=
 =?us-ascii?Q?hO0fZka/cQ8AhB9EX8lczxeK5XZT3GEXCNpMuT8RHe6NWS45Gey4w57Jxq8X?=
 =?us-ascii?Q?UlwLBOsihQINOPP7g+S+S0carQ8rIra91QEvHKRgD1ojvJsp2Zl7JzVRY1Ff?=
 =?us-ascii?Q?Np0kKSPoNwsMbrCsf00+k1oaQKn661Dsc6qYnC1jFCg09bj2yaMvrIF4Ku1y?=
 =?us-ascii?Q?z3nRnKVKGR16ol2HMa+Hpm4DzaaTBE+V0h827PULm4k6xpTkE1N+gR/R+wz+?=
 =?us-ascii?Q?n9g8ROT+DH7all5eYl6853wjZe4LbiyyCve3moecvx7ncZFwC/NsGyrDHuge?=
 =?us-ascii?Q?4bUVO0el+I9yhXMDCR1P9zJk0fCmhLn7AXjKJhslScwjS4RI8SzX6sbikmJx?=
 =?us-ascii?Q?z0ps9KdUuPNwBmSyKcBpB/lE2Cw3ZoT9bEzHHDwlStbrkQBqPyekTkATuVUk?=
 =?us-ascii?Q?oHCBPUXhTf+M0y1ag1swQ3NsHtLvxFWI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;23:av71PLoCOx4ZoMpA9bUrzIrxf3eEJXwBZOuGw6zPqB/QHC9HF2fRujZXH6L8GNfWJheEJQUZiFqxUd4sRljo7K+pW9+fLD8AF2HS8d+VrIk2nSeAuh1uilvMMhvRwqCHMxgKR7/O1+nGApanRMWUTw==;6:ejfbEo9vw89OTIKrxe/QCjBsrbpdp2bzuZ/hSeJ+z//0POaWBUDcRhvCs+rqeGojuxBENm0aUErkN+w+wp91iJjS5yxfT5t58IyFFmZC9eBCgwp/UMT2gdBxWPSRpDUb9NiRgEZrSU2Blxx2kStFc0+qJooKj6uvJg8BofT/c5Hlzycn7XJJY9VYrf/jk5HEhzzsD2fSgxlks1sNRB8Uubl+BYs0BbscXhbxLmDKyw5Gz0jO7nGJFtRw3oez2wN26UFAhCM8NuaFWVfU/n+BbYUYWRmirwKqmmN6anMLKQJToI9up8ivpHlud9ZKYppizRRnBxdElfQr6/malc0OOg2uofFy48YWrblM1yZhcikeJxZt0L3ijnefshQXspnWP01hSg8tX3XWwLhkHrTiT9zkd9EZFSm3QCVRSeVWlxzvxw2qm6mFdKeJem0t8tYE3VWuXaS4hHlfaakZ+B80sNPDcZGfw48DbjB6ML46RJ9W8Zc3yXSVoFEif+h9D0bF;5:6JoDS2u9N8MWdKpRH/SN6Ag+0Cj8RsNQSN+jdbCr2wwDcKqgbrUdHFCDNUngieZhtuh3frdGHMCqs2tw/zhhUcr0yqXurG/7k383ne1HiHeXBJF/h9MZTh8bmzdtYPEPuSI4gHZh2/2QHJp2DRQ9XcrQx6SHDvUfUn71lhGIxPQ=
X-Microsoft-Antispam-Message-Info: M23W1jXSCeYsluX4Zc0O48RC25Zn0AxaapPc3u5BbcUNvh3ZRX3QzGwr8mOb8YWX8ZPZcL0efJn6NuC5dZV/HtwObqf++PkH7VxP5rnc+7DFuImSOCpdQao2lEhTFOU4qq0J5vp1H2/jvN9mh5HEEkeUbpZktwQhyX71X/X+WXYnJDV90GSh8c+8Xyamt9BoCcvdlxKurDIV4TSdSgCf/9cJ1AnCi0uofdDp6RElB2UGV+f5m36VCnhgA/5HoEN6Fbk6QkFBW/VyHblOWKaDs0+aFM8uANz5nY0fwmQA5LppWRXo+hY6GDxhUnybjF5Get9yBR4cLVuOn6p0DbkK76L1naxbnnKVlRLLLUlIiUoI3+uBeATqz3rEw3By6fVuW+bzPm1FJZ7q241I8K7Ho4jlapUo36Xn242EeD/anBogNPMM1KL9Rqefl7BJNvzfeQpNpO4HZGhASNjEDqXR8X8VCeWzIFi+tQTnEAVCyyNI8G6donGqspDHmpxQp4GR2vxM/zqcRcG8Lx5BU60NQa2TNDi1PoFTVo4fc9UCLyAFbha3YGbLUwyTYy6OUesv
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;7:qJLjfcpWK5Wr4xllrSU5AG4ErgbrHFbIXsI2+mjs6pA5Cn192SFZ2QuF9xoisywEeQLo/LNYWS7hRiiy1kg73eqZDk3ufcPNvBkM3btCUZnkF2ZnViOyseLgZsscMRHGQSSdD1c141jK6YxxfJAipaxpSkbhkwGwg4/O0ALseyX/Woa5ElxpLwZs+WlFPvhklGN6JFC6+Dzxc4oBZc5JFxOTJF4eB/gOv9pXI3dO6ACBlvSUqTS6/JaBnC2JOykB;20:3wIMbIgeO/dhRh5Ft4U4KQ8ThLX9jaq+/Njw9F5ML8GAMlIZI3iIkh0W93BXXH6SSjfMoc65Vh5YUHw2SnPG3JEvjQJAI7EXeZxQVPHHVXtX/NO2eMTOsaivnsxpFvzFKkePD6o6euaGcpsXOEMHmaqwYpyhtRI+ymyeOnXsRTM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 15:55:37.9029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee3cc16-dbba-48b8-3ee4-08d5ddd8c262
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:25:56PM +0200, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Fri, Jun 29, 2018 at 03:10:14PM +0200, Vitaly Kuznetsov wrote:
> >> Roman Kagan <rkagan@virtuozzo.com> writes:
> >> 
> >> > On Fri, Jun 29, 2018 at 01:37:44PM +0200, Vitaly Kuznetsov wrote:
> >> >> The problem we're trying to solve here is: with PV TLB flush and IPI we
> >> >> need to walk through the supplied list of VP_INDEXes and get VCPU
> >> >> ids. Usually they match. But in case they don't [...]
> >> >
> >> > Why wouldn't they *in practice*?  Only if the userspace wanted to be
> >> > funny and assigned VP_INDEXes randomly?  I'm not sure we need to
> >> > optimize for this case.
> >> 
> >> Can someone please remind me why we allow userspace to change it in the
> >> first place?
> >
> > I can ;)
> >
> > We used not to, and reported KVM's vcpu index as the VP_INDEX.  However,
> > later we realized that VP_INDEX needed to be persistent across
> > migrations and otherwise also known to userspace.  Relying on the kernel
> > to always initialize its indices in the same order was unacceptable, and
> > we came up with no better way of synchronizing VP_INDEX between the
> > userspace and the kernel than to let the former to set it explicitly.
> >
> > However, this is basically a future-proofing feature; in practice, both
> > QEMU and KVM initialize their indices in the same order.
> 
> 
> Thanks!
> 
> But in the theoretical case when these indices start to differ after
> migration, users will notice a slowdown which will be hard to explain,
> right?

That's exactly why I suggested a warning on VP_INDEX != vcpu index in
kvm_hv_set_msr.

> Does it justify the need for vp_idx_to_vcpu_idx?

I'd personally prefer being pointed at a scenario where this becomes
relevant first.

Roman.
