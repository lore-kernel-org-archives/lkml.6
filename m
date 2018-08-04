Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D6DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 10:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E3217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 10:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0E3217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeHDMeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 08:34:16 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48299 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeHDMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 08:34:16 -0400
X-Originating-IP: 37.176.141.94
Received: from w540 (unknown [37.176.141.94])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 124221C0003;
        Sat,  4 Aug 2018 10:33:55 +0000 (UTC)
Date:   Sat, 4 Aug 2018 12:33:54 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 16/17] media: v4l2: async: Remove notifier subdevs
 array
Message-ID: <20180804103354.GB9285@w540>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-17-git-send-email-steve_longerbeam@mentor.com>
 <20180723123557.bfxxsqqhlaj3ccwc@valkosipuli.retiisi.org.uk>
 <a040c77f-2bee-5d0d-57ec-852ff30448e9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <a040c77f-2bee-5d0d-57ec-852ff30448e9@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Steve,

On Mon, Jul 23, 2018 at 09:44:57AM -0700, Steve Longerbeam wrote:
>
>
> On 07/23/2018 05:35 AM, Sakari Ailus wrote:
> >Hi Steve,
> >
> >Thanks for the update.
> >
> >On Mon, Jul 09, 2018 at 03:39:16PM -0700, Steve Longerbeam wrote:
> >>All platform drivers have been converted to use
> >>v4l2_async_notifier_add_subdev(), in place of adding
> >>asd's to the notifier subdevs array. So the subdevs
> >>array can now be removed from struct v4l2_async_notifier,
> >>and remove the backward compatibility support for that
> >>array in v4l2-async.c.
> >>
> >>Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >This set removes the subdevs and num_subdevs fieldsfrom the notifier (as
> >discussed previously) but it doesn't include the corresponding
> >driver changes. Is there a patch missing from the set?
>
> Hi Sakari, yes somehow patch 15/17 (the large patch to all drivers)
> got dropped by the ML, maybe because the cc-list was too big?
>
> I will resend with only linux-media and cc: you.

For the Renesas CEU and Renesas R-Car VIN you can add my:

Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

I would have a very small comment on the renesas-ceu.c patch. I'm copying
the hunk here below as the patch didn't reach the mailing list

>@@ -1562,40 +1557,46 @@ static int ceu_parse_dt(struct ceu_device *ceudev)
>                        dev_err(ceudev->dev,
>                                "No subdevice connected on endpoint %u.\n", i);
>                        ret = -ENODEV;
>-                       goto error_put_node;
>+                       goto error_cleanup;
>                }
>
>                ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &fw_ep);
>                if (ret) {
>                if (ret) {
>                        dev_err(ceudev->dev,
>                                "Unable to parse endpoint #%u.\n", i);
>-                       goto error_put_node;
>+                       goto error_cleanup;
>                }
>
>                if (fw_ep.bus_type != V4L2_MBUS_PARALLEL) {
>                        dev_err(ceudev->dev,
>                                "Only parallel input supported.\n");
>                        ret = -EINVAL;
>-                       goto error_put_node;
>+                       goto error_cleanup;
>                }
>
>                /* Setup the ceu subdevice and the async subdevice. */
>                ceu_sd = &ceudev->subdevs[i];
>                INIT_LIST_HEAD(&ceu_sd->asd.list);
>
>+               remote = of_graph_get_remote_port_parent(ep);
>                ceu_sd->mbus_flags = fw_ep.bus.parallel.flags;
>                ceu_sd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
>-               ceu_sd->asd.match.fwnode =
>-                       fwnode_graph_get_remote_port_parent(
>-                                       of_fwnode_handle(ep));
>+               ceu_sd->asd.match.fwnode = of_fwnode_handle(remote);
>+
>+               ret = v4l2_async_notifier_add_subdev(&ceudev->notifier,
>+                                                    &ceu_sd->asd);
>+               if (ret) {
>+                       of_node_put(remote);

                        ^^^ The 'remote' device node is only put in
                        the error path
>
>+                       goto error_cleanup;
>+               }
>
>-               ceudev->asds[i] = &ceu_sd->asd;
>                of_node_put(ep);
>        }
>
>        return num_ep;
>
>-error_put_node:
>+error_cleanup:
>+       v4l2_async_notifier_cleanup(&ceudev->notifier);
>        of_node_put(ep);
>        return ret;
> }

Thanks
   j

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbZYEHAAoJEHI0Bo8WoVY8D0YP/118mTcv2D47wecQgUINkN8L
UoNtkZS33DMSupbVeHb6KncVmxZkI2KN93siOp+UT/oxUZLQuSnQOXENojQRkN+E
7qVYvd7W7jy83vBL0OPuHSH8qnP1EDcgKGCkn+0VDLGRGlP1tCdV2B2fMEIH5lr2
VQYnIqXjI8DkR2LT5aW7UuUxojsf3NajuvV2JkKJzHtna2JFSw2Fm5G0fyb42/Uo
IXXDSCU1+vKZXaL5u4zgxYCClpJWjHIid+H+RPLttEUXKIml7TIYbzTYJtIaMzYo
A51rX8dSYGcb5M2EG6VsRfGok7VKfMMEevU2hBWIzxKqABE+EOcsEKf9lWJ1TGDA
B6Fe0qeCdmkT07wMwnXAvfhTkO6oO/dpziKzUnbS3odAKLYGIM6o1q2iKYzyDtHF
GAb0izQs0+4/m+jIz53hWURyDwv8QuGgrpjJkapZPJxaosbgs/Hsi/KJLqbUE35P
gxL60Q5hWynY7Lgq6+r5hG6xa+01LxxaHQl0gG5t1YxY7W9vU9Z6QQ1n3tmSmW2X
5yjKpLL4hEksDmqSA1HhPsi+IE/hx2OD7O5FjlSABcudJwpb6zlAeWiFPrNpfjC+
3M4V9gITTyTs+ObtCpWCEn73EUmlBeMrQkSlq79V+qEol9U1CVNuIyIyXmewf+Iq
z9A6Pr3Cj/BEaQyaCVQB
=N+md
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
