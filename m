Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AG47ELvKRCCUfJCt85XIjSj3dB+OayOLSpWB6tj4oYEE6rQHNulLfiuqFw0v4HkWmfsHDIzXhZgg
ARC-Seal: i=1; a=rsa-sha256; t=1521447310; cv=none;
        d=google.com; s=arc-20160816;
        b=HhbNKJM3oZSUdvvqsC3R4gTSFpcZDZtvNe+bdPuv7TejJjziAsyOs4M0Ahx0GkOCjC
         UDBlHLxCAVkgc2AwIZQhGTUTK6oQ+hzSSCvlz7xu//HoBJA3XVVOAiJ7rmOyHMmlpUfl
         HG6QSURtPlD9OAQ94Gb3JwzHGCznaBfKhrX9KOv9LioDTMy02C6n3ReXKcZzWb03R/2E
         Zc0cAZtnxTZTGxpn/EcDRBacKhtF26GZKUbw04LvbLuO5mVjDpon301L4J6+VsaWeGfE
         AlYnbnND/RB91/Drz5zzpnduxqqIhTkkWIoDe7BBu1cPew6t6sNTX0O/cLyJhsc9D2vs
         e6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=3REszllQ0dumGBJTFowH1uR2EFEHSLdzmBpTz+TQ/kg=;
        b=g4fRbXlL78uFSyz5OEV6KyUhufJFZKkfxB7upnq3Rm8giS3e3Tn9pgXUSFfIFHxHMp
         4PkJhzhTwdyZEiSTBfmqy31ldoy3vLQ/mAkNfREkWoq2O6hsrWgcpD2O/cSKxJZG+wbY
         ey4+C/J1ndux/w1p7oc6bA8/K0ilMecvMrkn+aduPPWkOE0Oo73nZXYeNwaQIuSoxrYi
         btGasbwV2eg4gidvfAwCZLT6/nbRujxXdZql+SeSYqd1vpdYUhup2NL/o3KYiD5N7pQC
         qt+IdLOAUneGERURQe2UX9eFt49fRXLdzOmyuLDKARfzr4vGfhgzkziMBm+kCg+TAChZ
         Mvaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=C/l4KBug;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=C/l4KBug;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Mon, 19 Mar 2018 11:14:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Doug Oucharek <dougso@me.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, "Drokin, Oleg" <oleg.drokin@intel.com>,
        "Dilger, Andreas" <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH] staging: lustre: o2iblnd: Stop MLX5 triggering a dump_cqe
Message-ID: <20180319081433.aqh6xt2t6b2bf22k@mwanda>
References: <B7D07263-126A-4156-AD60-3A58E8852865@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7D07263-126A-4156-AD60-3A58E8852865@me.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=642
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190007
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595139558236584574?=
X-GMAIL-MSGID: =?utf-8?q?1595353134708282744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I don't really understand this patch...

On Fri, Mar 16, 2018 at 04:40:21PM -0700, Doug Oucharek wrote:
> We have found that MLX5 will trigger a dump_cqe if we don't
> invalidate the rkey on a newly alloated MR for FastReg usage.
> 
> This fix just tags the MR as invalid on its creation if we are
> using FastReg and that will force it to do an invalidate of the
> rkey on first usage.

This paragraph makes the change seem like a limited workaround for a
bug in the MLX5 code.  Why can't the MLX5 code be fixed instead?

Looking at the patch it doesn't seem like a limitted solution at all.
Now frd->frd_valid is *always* set to false.  Why don't we instead just
delete ->frd_valid along with the newly dead code?

regards,
dan carpenter
