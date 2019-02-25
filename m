Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4305FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFAF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfBYOIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:08:16 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:55807 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfBYOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:08:15 -0500
Received: from cpe-2606-a000-111b-405a-9816-2c85-c514-8f7a.dyn6.twc.com ([2606:a000:111b:405a:9816:2c85:c514:8f7a] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gyGvD-0003nF-SL; Mon, 25 Feb 2019 09:08:08 -0500
Date:   Mon, 25 Feb 2019 09:07:20 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem <davem@davemloft.net>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] sctp: get sctphdr by offset in sctp_compute_cksum
Message-ID: <20190225140720.GC30699@hmswarspite.think-freely.org>
References: <2aee76766861ac9e46b7acf123d5d6e8f2adf8e0.1551093937.git.lucien.xin@gmail.com>
 <20190225124614.GB30699@hmswarspite.think-freely.org>
 <CADvbK_cC4q1D5w1AHAVQjCTW4Pm6H+-ZOVg7xCp+eiOkkRJ8SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_cC4q1D5w1AHAVQjCTW4Pm6H+-ZOVg7xCp+eiOkkRJ8SQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:20:44PM +0800, Xin Long wrote:
> On Mon, Feb 25, 2019 at 8:47 PM Neil Horman <nhorman@tuxdriver.com> wrote:
> >
> > On Mon, Feb 25, 2019 at 07:25:37PM +0800, Xin Long wrote:
> > > sctp_hdr(skb) only works when skb->transport_header is set properly.
> > >
> > > But in the path of nf_conntrack_in: sctp_packet() -> sctp_error()
> > >
> > > skb->transport_header is not guaranteed to be right value for sctp.
> > > It will cause to fail to check the checksum for sctp packets.
> > >
> > > So fix it by using offset, which is always right in all places.
> > >
> > > Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
> > > Reported-by: Li Shuang <shuali@redhat.com>
> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > ---
> > >  include/net/sctp/checksum.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
> > > index 32ee65a..1c6e6c0 100644
> > > --- a/include/net/sctp/checksum.h
> > > +++ b/include/net/sctp/checksum.h
> > > @@ -61,7 +61,7 @@ static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
> > >  static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
> > >                                       unsigned int offset)
> > >  {
> > > -     struct sctphdr *sh = sctp_hdr(skb);
> > > +     struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
> > >       const struct skb_checksum_ops ops = {
> > >               .update  = sctp_csum_update,
> > >               .combine = sctp_csum_combine,
> > > --
> > > 2.1.0
> > >
> > >
> > Shouldn't you use skb_set_transport_header and skb_transport_header here?
> you mean:
> skb_set_transport_header(skb, offset);
> sh = sctp_hdr(skb);
> ?
> 
> There's no place counting on here to set transport_header.
> It will be a kinda redundant job, yet skb is 'const'.
> 
I'm not sure what you mean by "theres no place counting here".  We have the
transport header offset, and you're doing the exact same computation that that
function does.  It seems like we should use it in case the underlying
implementation changes. 

I understand what you are saying regarding the use of a const variable there,
but perhaps thats an argument for removing the const storage classifier.  Better
still, it would be good to figure out why all paths to this function don't
already set the transport header offset to begin with (addressing your redundant
comment)

Regards
Neil

