Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E953C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6545620851
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3PdbTka/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6545620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeKUWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:10:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeKUWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:10:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wALBTUkq139414;
        Wed, 21 Nov 2018 11:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=6wqoCmnDUzdss297jnn1NtxeFvkwhaG6Zb/m/Ppwd5E=;
 b=3PdbTka/uIn9Y3+f9wv9CXw/uOCrzQl9RDfMXKf7Bq4436Yr0fY2jkBXsbO37CoxY4UI
 K6Jhcx2/Hpm5qYTmVtfiFNRp47gEh0g/q8Kg5Urc3KT20UTCQvykdFzi7MlAY/F4byLy
 Kv/PI8QoTi5GejIRc/ZhdxBvYbTx8OoKaRxYShDMUXTsdowsq1TejnqIqcX4pxbms/RW
 QfCVasJWuknBLB+fksCTJHt8Zm7VlGUSrpwW6bjfDWON2qd1ioXPlsvYDRDVVUvpB9rV
 Q8L9X+jA9rKS2bJL5I2yNbBRxGwWgiXlH9sacYHm7dSbo8+ku5liwl5+eNTE8G/Hx/68 Qw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ntadu12c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 11:35:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wALBZnk5030137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 11:35:49 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wALBZm1h005344;
        Wed, 21 Nov 2018 11:35:48 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Nov 2018 03:35:48 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1 8/8] PM / Hibernate: exclude all PageOffline() pages
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181119101616.8901-9-david@redhat.com>
Date:   Wed, 21 Nov 2018 04:35:46 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, devel@linuxdriverproject.org,
        linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11E3C0B0-AEED-42C6-A21C-1820F4B47A68@oracle.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-9-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9083 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811210104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you are adding PageOffline(page) to the condition list of the already =
existing if in
saveable_highmem_page(), why explicitly add it as a separate statement =
in saveable_page()?

It would seem more consistent to make the second check:

-	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
+	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page) =
||
+		PageOffline(page))

instead.

It's admittedly a nit but it just seems cleaner to either do that or, if =
your intention
was to separate the Page checks from the swsusp checks, to break the =
calls to
PageReserved() and PageOffline() into their own check in =
saveable_highmem_page().

Thanks!
    -- Bill
    =20

> On Nov 19, 2018, at 3:16 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct =
zone *zone, unsigned long pfn)
> 	BUG_ON(!PageHighMem(page));
>=20
> 	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) =
||
> -	    PageReserved(page))
> +	    PageReserved(page) || PageOffline(page))
> 		return NULL;
>=20
> 	if (page_is_guard(page))
> @@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone =
*zone, unsigned long pfn)
> 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> 		return NULL;
>=20
> +	if (PageOffline(page))
> +		return NULL;
> +
> 	if (PageReserved(page)
> 	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
> 		return NULL;
> --=20
> 2.17.2
>=20

