Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B45C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC082437D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sFpgF/+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC082437D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeGDNFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:05:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33842 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbeGDNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:05:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w64D4ZEJ027688;
        Wed, 4 Jul 2018 13:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=+3y4zvhmYQpx8CoIlC5ewKiecQz0MZxoDPaEVFPzVek=;
 b=sFpgF/+Gnuw6akFSveiIfg7xURPLRcBuSQd9XMQ7GzsTaR001dvVoo1AXDHrn6Nthcic
 lPQygbzQxx8TyuXJ68CoFs1O5dTxT3HjsPwfXbWfry3Oo5cRERV4FyRm87IBW7KICEvY
 6PNGna0/Z8xC/Wx29Bksiz7iIeZQBvLY5C1fPsB3dQXJJaSV+mEqS1esTtq2BewvhUdZ
 RjHL8ilQcxLak8ko3HWP2vg7gcCHonodworVb/qW/q8DOGV8td9WJjIfIOUKMC0uXDir
 SlqoQee3AI9wCEj7zVmtBhEewWXQoX1y8nYKi7Kt5/HkqWEO/Ve3ng4oTeHAVGrXpPuT xA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k0dnt2qpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jul 2018 13:05:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w64D55a1005372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jul 2018 13:05:06 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w64D53OA022400;
        Wed, 4 Jul 2018 13:05:04 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Jul 2018 06:05:03 -0700
Date:   Wed, 4 Jul 2018 16:04:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        devel@driverdev.osuosl.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
Message-ID: <20180704130448.pta7t5joj5qrxlpq@mwanda>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=831
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807040151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 04:03:33PM +0800, Jian-Hong Pan wrote:
> Hi,
> 
> We have an ASUS X530UN (Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz)
> laptop equipped with Realtek rtl8822be wireless which cannot find any
> access point after WiFi is launched.
> 
> Realtek rtl8822be wireless' information:
> dev@endless:~/linux-eos$ sudo lspci -nnvs 02:00.0
> 02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd.
> Device [10ec:b822] (rev ff) (prog-if ff)
> !!! Unknown header type 7f
> Kernel driver in use: r8822be
> Kernel modules: r8822be
> 
> System always hits the error: "halmac_init_hal failed" in dmesg after
> WiFi is launched.
> 
> [ 8.591333] r8822be: module is from the staging directory, the quality
> is unknown, you have been warned.
> [ 8.593122] r8822be 0000:02:00.0: enabling device (0000 -> 0003)
> [ 8.669163] r8822be: Using firmware rtlwifi/rtl8822befw.bin
> [ 9.289939] r8822be: rtlwifi: wireless switch is on
> [ 10.056426] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
> ...
> [ 11.952534] r8822be: halmac_init_hal failed
> [ 11.955933] r8822be: halmac_init_hal failed
> [ 11.956227] r8822be: halmac_init_hal failed
> [ 22.007942] r8822be: halmac_init_hal failed

I really prefer to see the whole dmesg instead of an edited ... in the
middle.

I agree that it feels like the default aspm setting should be 2 (use
what the chip says).  Although I don't know the device well enough to
say if that will break anyone's system.  Perhaps someone who knows
better will be able to respond.

regards,
dan carpenter

