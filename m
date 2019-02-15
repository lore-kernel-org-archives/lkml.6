Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9993C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FDD2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yYfd/4Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394780AbfBOM51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:57:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48264 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393866AbfBOM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:57:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1FCmuHc057994;
        Fri, 15 Feb 2019 12:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=54XMQOGrhhy1vVzkQDKzDYVxcLSETtsMppeiKZNRsts=;
 b=yYfd/4FxQEa/0Fuxh4BfE/EW0lXrMIlmPYy5vXUBM9FHhbKLEcOTOA4VyjDhuggMwB1a
 TkKXbUUQu+7+VPsLPvIs3uXGp99JrR86cjAHz4V974n/3FRh8YZugzdFpqHBEOX6F4Rc
 SZnk1gZvgE+iNysjglIw0Bzpzv+PeJGcpCe7VCXnAfIr/hqjsUo4b9fM2i9c+Um9JlBV
 WVCEQDBI8DTyIVn0+jtt49SeLb0R/54z0FzAEwyqR+p1tw3o5FUm/VbVXL2hqS7zCGxP
 VvCxNdK5bweTqQwSt+23QDEREE9W9UEGWfuLo9vuLVPHCvnkBIf1J0IikvbsG44xpSby Sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qhre5wp7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 12:57:11 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1FCvBXl006439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 12:57:11 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1FCv9V1020313;
        Fri, 15 Feb 2019 12:57:09 GMT
Received: from kadam (/197.157.0.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 04:57:08 -0800
Date:   Fri, 15 Feb 2019 15:57:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8822be: check kzalloc return or bail
Message-ID: <20190215125659.GI2326@kadam>
References: <1550222662-32124-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550222662-32124-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:24:22AM +0100, Nicholas Mc Guire wrote:
> The kzalloc() in halmac_parse_psd_data_88xx() can fail and return NULL
> so check the psd_set->data after allocation and if allocation failed
> return HALMAC_CMD_PROCESS_ERROR.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 938a0447f094 ("staging: r8822be: Add code for halmac sub-drive")
> ---
> 
> Problem was located with an experimental coccinelle script
> 
> Patch was compile tested with: x86_64_defconfig + STAGING=y,
> R8822BE=m
> (with a smatch error that looks like a false-positive
> 
>   CHECK   drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
> drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c:624 halmac_func_write_logical_efuse_88xx() error: uninitialized symbol 'pg_efuse_header2'.
>   CC [M]  drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.o
> 
> as the initialization of pg_efuse_header2 is under the same if condition (line 592) as the
> use at line 624 it is initialized)
>

Hm...  That's tricky code for Smatch to parse.

drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
   592                  if (offset > 0x7f) {
   593                          pg_efuse_header =
   594                                  (((pg_block & 0x07) << 5) & 0xE0) | 0x0F;
   595                          pg_efuse_header2 =
                                ^^^^^^^^^^^^^^^^^^
pg_efuse_header2 is only intialized on this path.

   596                                  (u8)(((pg_block & 0x78) << 1) +
   597                                       ((0x1 << pg_block_index) ^ 0x0F));
   598                  } else {
   599                          pg_efuse_header =
   600                                  (u8)((pg_block << 4) +
   601                                       ((0x01 << pg_block_index) ^ 0x0F));
   602                  }
   603  
   604                  if ((offset & 1) == 0) {
                            ^^^^^^^^^^^^^^^^^
But this condition confuses Smatch.  Smatch marks it as saying that
offset is non-zero on this size.

   605                          pg_efuse_byte1 = value;
   606                          pg_efuse_byte2 = *(eeprom_map + offset + 1);
   607                  } else {

And this side offset = 0-0x7e.

   608                          pg_efuse_byte1 = *(eeprom_map + offset - 1);
   609                          pg_efuse_byte2 = value;
   610                  }
   611  
   612                  if (offset > 0x7f) {
                            ^^^^^^^^^^^^^
So it doesn't parse this condition correctly.

   613                          pg_efuse_num = 4;
   614                          if (halmac_adapter->hw_config_info.efuse_size <=
   615                              (pg_efuse_num + HALMAC_PROTECTED_EFUSE_SIZE_88XX +
   616                               halmac_adapter->efuse_end)) {
   617                                  kfree(eeprom_map);
   618                                  return HALMAC_RET_EFUSE_NOT_ENOUGH;
   619                          }
   620                          halmac_func_write_efuse_88xx(halmac_adapter, efuse_end,
   621                                                       pg_efuse_header);
   622                          halmac_func_write_efuse_88xx(halmac_adapter,
   623                                                       efuse_end + 1,
   624                                                       pg_efuse_header2);
                                                             ^^^^^^^^^^^^^^^^
And it warns here.

   625                          halmac_func_write_efuse_88xx(
   626                                  halmac_adapter, efuse_end + 2, pg_efuse_byte1);
   627                          status = halmac_func_write_efuse_88xx(
   628                                  halmac_adapter, efuse_end + 3, pg_efuse_byte2);


It should be possible to fix this false positive...  It's just a matter
of doing the work.

regards,
dan carpenter
