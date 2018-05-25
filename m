Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030507AbeEYVhX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:37:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:26857 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030216AbeEYVhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:37:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="gz'50?scan'50,208,50";a="53915469"
Date: Sat, 26 May 2018 05:36:25 +0800
From: kbuild test robot <lkp@intel.com>
To: Greg Thelen <gthelen@google.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: net/9p/trans_rdma.c:551: undefined reference to `rdma_disconnect'
Message-ID: <201805260515.NN1ix0qg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   62d18ecfa64137349fac9c5817784fbd48b54f48
commit: 9533b292a7acc62c294ebcbd9e1f9f9d52adb10b IB: remove redundant INFINIBAND kconfig dependencies
date:   2 weeks ago
config: x86_64-randconfig-x003-05251014 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 9533b292a7acc62c294ebcbd9e1f9f9d52adb10b
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   net/9p/trans_rdma.o: In function `rdma_request':
>> net/9p/trans_rdma.c:551: undefined reference to `rdma_disconnect'
   net/9p/trans_rdma.o: In function `rdma_destroy_trans':
>> net/9p/trans_rdma.c:383: undefined reference to `ib_destroy_qp'
>> net/9p/trans_rdma.c:386: undefined reference to `ib_dealloc_pd'
>> net/9p/trans_rdma.c:389: undefined reference to `ib_free_cq'
>> net/9p/trans_rdma.c:392: undefined reference to `rdma_destroy_id'
   net/9p/trans_rdma.o: In function `rdma_close':
   net/9p/trans_rdma.c:569: undefined reference to `rdma_disconnect'
   net/9p/trans_rdma.o: In function `p9_cm_event_handler':
   net/9p/trans_rdma.c:298: undefined reference to `rdma_disconnect'
   net/9p/trans_rdma.o: In function `rdma_create_trans':
>> net/9p/trans_rdma.c:660: undefined reference to `__rdma_create_id'
   net/9p/trans_rdma.o: In function `p9_rdma_bind_privport':
>> net/9p/trans_rdma.c:627: undefined reference to `rdma_bind_addr'
   net/9p/trans_rdma.o: In function `rdma_create_trans':
>> net/9p/trans_rdma.c:682: undefined reference to `rdma_resolve_addr'
>> net/9p/trans_rdma.c:692: undefined reference to `rdma_resolve_route'
>> net/9p/trans_rdma.c:700: undefined reference to `__ib_alloc_cq'
>> net/9p/trans_rdma.c:707: undefined reference to `__ib_alloc_pd'
>> net/9p/trans_rdma.c:723: undefined reference to `rdma_create_qp'
>> net/9p/trans_rdma.c:734: undefined reference to `rdma_connect'

vim +551 net/9p/trans_rdma.c

fc79d4b1 Tom Tucker         2008-10-22  376  
fc79d4b1 Tom Tucker         2008-10-22  377  static void rdma_destroy_trans(struct p9_trans_rdma *rdma)
fc79d4b1 Tom Tucker         2008-10-22  378  {
fc79d4b1 Tom Tucker         2008-10-22  379  	if (!rdma)
fc79d4b1 Tom Tucker         2008-10-22  380  		return;
fc79d4b1 Tom Tucker         2008-10-22  381  
fc79d4b1 Tom Tucker         2008-10-22  382  	if (rdma->qp && !IS_ERR(rdma->qp))
fc79d4b1 Tom Tucker         2008-10-22 @383  		ib_destroy_qp(rdma->qp);
fc79d4b1 Tom Tucker         2008-10-22  384  
fc79d4b1 Tom Tucker         2008-10-22  385  	if (rdma->pd && !IS_ERR(rdma->pd))
fc79d4b1 Tom Tucker         2008-10-22 @386  		ib_dealloc_pd(rdma->pd);
fc79d4b1 Tom Tucker         2008-10-22  387  
fc79d4b1 Tom Tucker         2008-10-22  388  	if (rdma->cq && !IS_ERR(rdma->cq))
7cf20fc6 Christoph Hellwig  2016-03-03 @389  		ib_free_cq(rdma->cq);
fc79d4b1 Tom Tucker         2008-10-22  390  
fc79d4b1 Tom Tucker         2008-10-22  391  	if (rdma->cm_id && !IS_ERR(rdma->cm_id))
fc79d4b1 Tom Tucker         2008-10-22 @392  		rdma_destroy_id(rdma->cm_id);
fc79d4b1 Tom Tucker         2008-10-22  393  
fc79d4b1 Tom Tucker         2008-10-22  394  	kfree(rdma);
fc79d4b1 Tom Tucker         2008-10-22  395  }
fc79d4b1 Tom Tucker         2008-10-22  396  
fc79d4b1 Tom Tucker         2008-10-22  397  static int
fc79d4b1 Tom Tucker         2008-10-22  398  post_recv(struct p9_client *client, struct p9_rdma_context *c)
fc79d4b1 Tom Tucker         2008-10-22  399  {
fc79d4b1 Tom Tucker         2008-10-22  400  	struct p9_trans_rdma *rdma = client->trans;
fc79d4b1 Tom Tucker         2008-10-22  401  	struct ib_recv_wr wr, *bad_wr;
fc79d4b1 Tom Tucker         2008-10-22  402  	struct ib_sge sge;
fc79d4b1 Tom Tucker         2008-10-22  403  
fc79d4b1 Tom Tucker         2008-10-22  404  	c->busa = ib_dma_map_single(rdma->cm_id->device,
fc79d4b1 Tom Tucker         2008-10-22  405  				    c->rc->sdata, client->msize,
fc79d4b1 Tom Tucker         2008-10-22  406  				    DMA_FROM_DEVICE);
fc79d4b1 Tom Tucker         2008-10-22  407  	if (ib_dma_mapping_error(rdma->cm_id->device, c->busa))
fc79d4b1 Tom Tucker         2008-10-22  408  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  409  
7cf20fc6 Christoph Hellwig  2016-03-03  410  	c->cqe.done = recv_done;
7cf20fc6 Christoph Hellwig  2016-03-03  411  
fc79d4b1 Tom Tucker         2008-10-22  412  	sge.addr = c->busa;
fc79d4b1 Tom Tucker         2008-10-22  413  	sge.length = client->msize;
2f31fa88 Jason Gunthorpe    2015-07-30  414  	sge.lkey = rdma->pd->local_dma_lkey;
fc79d4b1 Tom Tucker         2008-10-22  415  
fc79d4b1 Tom Tucker         2008-10-22  416  	wr.next = NULL;
7cf20fc6 Christoph Hellwig  2016-03-03  417  	wr.wr_cqe = &c->cqe;
fc79d4b1 Tom Tucker         2008-10-22  418  	wr.sg_list = &sge;
fc79d4b1 Tom Tucker         2008-10-22  419  	wr.num_sge = 1;
fc79d4b1 Tom Tucker         2008-10-22  420  	return ib_post_recv(rdma->qp, &wr, &bad_wr);
fc79d4b1 Tom Tucker         2008-10-22  421  
fc79d4b1 Tom Tucker         2008-10-22  422   error:
5d385153 Joe Perches        2011-11-28  423  	p9_debug(P9_DEBUG_ERROR, "EIO\n");
fc79d4b1 Tom Tucker         2008-10-22  424  	return -EIO;
fc79d4b1 Tom Tucker         2008-10-22  425  }
fc79d4b1 Tom Tucker         2008-10-22  426  
fc79d4b1 Tom Tucker         2008-10-22  427  static int rdma_request(struct p9_client *client, struct p9_req_t *req)
fc79d4b1 Tom Tucker         2008-10-22  428  {
fc79d4b1 Tom Tucker         2008-10-22  429  	struct p9_trans_rdma *rdma = client->trans;
fc79d4b1 Tom Tucker         2008-10-22  430  	struct ib_send_wr wr, *bad_wr;
fc79d4b1 Tom Tucker         2008-10-22  431  	struct ib_sge sge;
fc79d4b1 Tom Tucker         2008-10-22  432  	int err = 0;
fc79d4b1 Tom Tucker         2008-10-22  433  	unsigned long flags;
fc79d4b1 Tom Tucker         2008-10-22  434  	struct p9_rdma_context *c = NULL;
fc79d4b1 Tom Tucker         2008-10-22  435  	struct p9_rdma_context *rpl_context = NULL;
fc79d4b1 Tom Tucker         2008-10-22  436  
1cff3306 Simon Derr         2013-06-21  437  	/* When an error occurs between posting the recv and the send,
1cff3306 Simon Derr         2013-06-21  438  	 * there will be a receive context posted without a pending request.
1cff3306 Simon Derr         2013-06-21  439  	 * Since there is no way to "un-post" it, we remember it and skip
1cff3306 Simon Derr         2013-06-21  440  	 * post_recv() for the next request.
1cff3306 Simon Derr         2013-06-21  441  	 * So here,
1cff3306 Simon Derr         2013-06-21  442  	 * see if we are this `next request' and need to absorb an excess rc.
1cff3306 Simon Derr         2013-06-21  443  	 * If yes, then drop and free our own, and do not recv_post().
1cff3306 Simon Derr         2013-06-21  444  	 **/
1cff3306 Simon Derr         2013-06-21  445  	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
1cff3306 Simon Derr         2013-06-21  446  		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
1cff3306 Simon Derr         2013-06-21  447  			/* Got one ! */
1cff3306 Simon Derr         2013-06-21  448  			kfree(req->rc);
1cff3306 Simon Derr         2013-06-21  449  			req->rc = NULL;
1cff3306 Simon Derr         2013-06-21  450  			goto dont_need_post_recv;
1cff3306 Simon Derr         2013-06-21  451  		} else {
1cff3306 Simon Derr         2013-06-21  452  			/* We raced and lost. */
1cff3306 Simon Derr         2013-06-21  453  			atomic_inc(&rdma->excess_rc);
1cff3306 Simon Derr         2013-06-21  454  		}
1cff3306 Simon Derr         2013-06-21  455  	}
1cff3306 Simon Derr         2013-06-21  456  
fc79d4b1 Tom Tucker         2008-10-22  457  	/* Allocate an fcall for the reply */
eeff66ef Aneesh Kumar K.V   2011-03-08  458  	rpl_context = kmalloc(sizeof *rpl_context, GFP_NOFS);
1d6400c7 Davidlohr Bueso    2010-09-13  459  	if (!rpl_context) {
1d6400c7 Davidlohr Bueso    2010-09-13  460  		err = -ENOMEM;
2f52d07c Simon Derr         2013-06-21  461  		goto recv_error;
1d6400c7 Davidlohr Bueso    2010-09-13  462  	}
fc79d4b1 Tom Tucker         2008-10-22  463  	rpl_context->rc = req->rc;
fc79d4b1 Tom Tucker         2008-10-22  464  
fc79d4b1 Tom Tucker         2008-10-22  465  	/*
fc79d4b1 Tom Tucker         2008-10-22  466  	 * Post a receive buffer for this request. We need to ensure
fc79d4b1 Tom Tucker         2008-10-22  467  	 * there is a reply buffer available for every outstanding
fc79d4b1 Tom Tucker         2008-10-22  468  	 * request. A flushed request can result in no reply for an
fc79d4b1 Tom Tucker         2008-10-22  469  	 * outstanding request, so we must keep a count to avoid
fc79d4b1 Tom Tucker         2008-10-22  470  	 * overflowing the RQ.
fc79d4b1 Tom Tucker         2008-10-22  471  	 */
2f52d07c Simon Derr         2013-06-21  472  	if (down_interruptible(&rdma->rq_sem)) {
2f52d07c Simon Derr         2013-06-21  473  		err = -EINTR;
2f52d07c Simon Derr         2013-06-21  474  		goto recv_error;
2f52d07c Simon Derr         2013-06-21  475  	}
fd453d0e Simon Derr         2013-06-21  476  
fc79d4b1 Tom Tucker         2008-10-22  477  	err = post_recv(client, rpl_context);
fd453d0e Simon Derr         2013-06-21  478  	if (err) {
fd453d0e Simon Derr         2013-06-21  479  		p9_debug(P9_DEBUG_FCALL, "POST RECV failed\n");
2f52d07c Simon Derr         2013-06-21  480  		goto recv_error;
fd453d0e Simon Derr         2013-06-21  481  	}
fc79d4b1 Tom Tucker         2008-10-22  482  	/* remove posted receive buffer from request structure */
fc79d4b1 Tom Tucker         2008-10-22  483  	req->rc = NULL;
fc79d4b1 Tom Tucker         2008-10-22  484  
1cff3306 Simon Derr         2013-06-21  485  dont_need_post_recv:
fc79d4b1 Tom Tucker         2008-10-22  486  	/* Post the request */
eeff66ef Aneesh Kumar K.V   2011-03-08  487  	c = kmalloc(sizeof *c, GFP_NOFS);
1d6400c7 Davidlohr Bueso    2010-09-13  488  	if (!c) {
1d6400c7 Davidlohr Bueso    2010-09-13  489  		err = -ENOMEM;
2f52d07c Simon Derr         2013-06-21  490  		goto send_error;
1d6400c7 Davidlohr Bueso    2010-09-13  491  	}
fc79d4b1 Tom Tucker         2008-10-22  492  	c->req = req;
fc79d4b1 Tom Tucker         2008-10-22  493  
fc79d4b1 Tom Tucker         2008-10-22  494  	c->busa = ib_dma_map_single(rdma->cm_id->device,
fc79d4b1 Tom Tucker         2008-10-22  495  				    c->req->tc->sdata, c->req->tc->size,
fc79d4b1 Tom Tucker         2008-10-22  496  				    DMA_TO_DEVICE);
2f52d07c Simon Derr         2013-06-21  497  	if (ib_dma_mapping_error(rdma->cm_id->device, c->busa)) {
2f52d07c Simon Derr         2013-06-21  498  		err = -EIO;
2f52d07c Simon Derr         2013-06-21  499  		goto send_error;
2f52d07c Simon Derr         2013-06-21  500  	}
fc79d4b1 Tom Tucker         2008-10-22  501  
7cf20fc6 Christoph Hellwig  2016-03-03  502  	c->cqe.done = send_done;
7cf20fc6 Christoph Hellwig  2016-03-03  503  
fc79d4b1 Tom Tucker         2008-10-22  504  	sge.addr = c->busa;
fc79d4b1 Tom Tucker         2008-10-22  505  	sge.length = c->req->tc->size;
2f31fa88 Jason Gunthorpe    2015-07-30  506  	sge.lkey = rdma->pd->local_dma_lkey;
fc79d4b1 Tom Tucker         2008-10-22  507  
fc79d4b1 Tom Tucker         2008-10-22  508  	wr.next = NULL;
7cf20fc6 Christoph Hellwig  2016-03-03  509  	wr.wr_cqe = &c->cqe;
fc79d4b1 Tom Tucker         2008-10-22  510  	wr.opcode = IB_WR_SEND;
fc79d4b1 Tom Tucker         2008-10-22  511  	wr.send_flags = IB_SEND_SIGNALED;
fc79d4b1 Tom Tucker         2008-10-22  512  	wr.sg_list = &sge;
fc79d4b1 Tom Tucker         2008-10-22  513  	wr.num_sge = 1;
fc79d4b1 Tom Tucker         2008-10-22  514  
2f52d07c Simon Derr         2013-06-21  515  	if (down_interruptible(&rdma->sq_sem)) {
2f52d07c Simon Derr         2013-06-21  516  		err = -EINTR;
2f52d07c Simon Derr         2013-06-21  517  		goto send_error;
2f52d07c Simon Derr         2013-06-21  518  	}
2f52d07c Simon Derr         2013-06-21  519  
3f9d5b8d Simon Derr         2014-03-10  520  	/* Mark request as `sent' *before* we actually send it,
3f9d5b8d Simon Derr         2014-03-10  521  	 * because doing if after could erase the REQ_STATUS_RCVD
3f9d5b8d Simon Derr         2014-03-10  522  	 * status in case of a very fast reply.
3f9d5b8d Simon Derr         2014-03-10  523  	 */
3f9d5b8d Simon Derr         2014-03-10  524  	req->status = REQ_STATUS_SENT;
2f52d07c Simon Derr         2013-06-21  525  	err = ib_post_send(rdma->qp, &wr, &bad_wr);
2f52d07c Simon Derr         2013-06-21  526  	if (err)
2f52d07c Simon Derr         2013-06-21  527  		goto send_error;
fc79d4b1 Tom Tucker         2008-10-22  528  
2f52d07c Simon Derr         2013-06-21  529  	/* Success */
2f52d07c Simon Derr         2013-06-21  530  	return 0;
fc79d4b1 Tom Tucker         2008-10-22  531  
2f52d07c Simon Derr         2013-06-21  532   /* Handle errors that happened during or while preparing the send: */
2f52d07c Simon Derr         2013-06-21  533   send_error:
3f9d5b8d Simon Derr         2014-03-10  534  	req->status = REQ_STATUS_ERROR;
1d6400c7 Davidlohr Bueso    2010-09-13  535  	kfree(c);
2f52d07c Simon Derr         2013-06-21  536  	p9_debug(P9_DEBUG_ERROR, "Error %d in rdma_request()\n", err);
1cff3306 Simon Derr         2013-06-21  537  
1cff3306 Simon Derr         2013-06-21  538  	/* Ach.
1cff3306 Simon Derr         2013-06-21  539  	 *  We did recv_post(), but not send. We have one recv_post in excess.
1cff3306 Simon Derr         2013-06-21  540  	 */
1cff3306 Simon Derr         2013-06-21  541  	atomic_inc(&rdma->excess_rc);
2f52d07c Simon Derr         2013-06-21  542  	return err;
2f52d07c Simon Derr         2013-06-21  543  
2f52d07c Simon Derr         2013-06-21  544   /* Handle errors that happened during or while preparing post_recv(): */
2f52d07c Simon Derr         2013-06-21  545   recv_error:
1d6400c7 Davidlohr Bueso    2010-09-13  546  	kfree(rpl_context);
fc79d4b1 Tom Tucker         2008-10-22  547  	spin_lock_irqsave(&rdma->req_lock, flags);
fc79d4b1 Tom Tucker         2008-10-22  548  	if (rdma->state < P9_RDMA_CLOSING) {
fc79d4b1 Tom Tucker         2008-10-22  549  		rdma->state = P9_RDMA_CLOSING;
fc79d4b1 Tom Tucker         2008-10-22  550  		spin_unlock_irqrestore(&rdma->req_lock, flags);
fc79d4b1 Tom Tucker         2008-10-22 @551  		rdma_disconnect(rdma->cm_id);
fc79d4b1 Tom Tucker         2008-10-22  552  	} else
fc79d4b1 Tom Tucker         2008-10-22  553  		spin_unlock_irqrestore(&rdma->req_lock, flags);
fc79d4b1 Tom Tucker         2008-10-22  554  	return err;
fc79d4b1 Tom Tucker         2008-10-22  555  }
fc79d4b1 Tom Tucker         2008-10-22  556  
fc79d4b1 Tom Tucker         2008-10-22  557  static void rdma_close(struct p9_client *client)
fc79d4b1 Tom Tucker         2008-10-22  558  {
fc79d4b1 Tom Tucker         2008-10-22  559  	struct p9_trans_rdma *rdma;
fc79d4b1 Tom Tucker         2008-10-22  560  
fc79d4b1 Tom Tucker         2008-10-22  561  	if (!client)
fc79d4b1 Tom Tucker         2008-10-22  562  		return;
fc79d4b1 Tom Tucker         2008-10-22  563  
fc79d4b1 Tom Tucker         2008-10-22  564  	rdma = client->trans;
fc79d4b1 Tom Tucker         2008-10-22  565  	if (!rdma)
fc79d4b1 Tom Tucker         2008-10-22  566  		return;
fc79d4b1 Tom Tucker         2008-10-22  567  
fc79d4b1 Tom Tucker         2008-10-22  568  	client->status = Disconnected;
fc79d4b1 Tom Tucker         2008-10-22 @569  	rdma_disconnect(rdma->cm_id);
fc79d4b1 Tom Tucker         2008-10-22  570  	rdma_destroy_trans(rdma);
fc79d4b1 Tom Tucker         2008-10-22  571  }
fc79d4b1 Tom Tucker         2008-10-22  572  
fc79d4b1 Tom Tucker         2008-10-22  573  /**
fc79d4b1 Tom Tucker         2008-10-22  574   * alloc_rdma - Allocate and initialize the rdma transport structure
fc79d4b1 Tom Tucker         2008-10-22  575   * @opts: Mount options structure
fc79d4b1 Tom Tucker         2008-10-22  576   */
fc79d4b1 Tom Tucker         2008-10-22  577  static struct p9_trans_rdma *alloc_rdma(struct p9_rdma_opts *opts)
fc79d4b1 Tom Tucker         2008-10-22  578  {
fc79d4b1 Tom Tucker         2008-10-22  579  	struct p9_trans_rdma *rdma;
fc79d4b1 Tom Tucker         2008-10-22  580  
fc79d4b1 Tom Tucker         2008-10-22  581  	rdma = kzalloc(sizeof(struct p9_trans_rdma), GFP_KERNEL);
fc79d4b1 Tom Tucker         2008-10-22  582  	if (!rdma)
fc79d4b1 Tom Tucker         2008-10-22  583  		return NULL;
fc79d4b1 Tom Tucker         2008-10-22  584  
c4fac910 David Howells      2017-07-05  585  	rdma->port = opts->port;
c4fac910 David Howells      2017-07-05  586  	rdma->privport = opts->privport;
fc79d4b1 Tom Tucker         2008-10-22  587  	rdma->sq_depth = opts->sq_depth;
fc79d4b1 Tom Tucker         2008-10-22  588  	rdma->rq_depth = opts->rq_depth;
fc79d4b1 Tom Tucker         2008-10-22  589  	rdma->timeout = opts->timeout;
fc79d4b1 Tom Tucker         2008-10-22  590  	spin_lock_init(&rdma->req_lock);
fc79d4b1 Tom Tucker         2008-10-22  591  	init_completion(&rdma->cm_done);
fc79d4b1 Tom Tucker         2008-10-22  592  	sema_init(&rdma->sq_sem, rdma->sq_depth);
fd453d0e Simon Derr         2013-06-21  593  	sema_init(&rdma->rq_sem, rdma->rq_depth);
1cff3306 Simon Derr         2013-06-21  594  	atomic_set(&rdma->excess_rc, 0);
fc79d4b1 Tom Tucker         2008-10-22  595  
fc79d4b1 Tom Tucker         2008-10-22  596  	return rdma;
fc79d4b1 Tom Tucker         2008-10-22  597  }
fc79d4b1 Tom Tucker         2008-10-22  598  
fc79d4b1 Tom Tucker         2008-10-22  599  static int rdma_cancel(struct p9_client *client, struct p9_req_t *req)
fc79d4b1 Tom Tucker         2008-10-22  600  {
931700d2 Simon Derr         2014-03-10  601  	/* Nothing to do here.
931700d2 Simon Derr         2014-03-10  602  	 * We will take care of it (if we have to) in rdma_cancelled()
931700d2 Simon Derr         2014-03-10  603  	 */
fc79d4b1 Tom Tucker         2008-10-22  604  	return 1;
fc79d4b1 Tom Tucker         2008-10-22  605  }
fc79d4b1 Tom Tucker         2008-10-22  606  
931700d2 Simon Derr         2014-03-10  607  /* A request has been fully flushed without a reply.
931700d2 Simon Derr         2014-03-10  608   * That means we have posted one buffer in excess.
931700d2 Simon Derr         2014-03-10  609   */
931700d2 Simon Derr         2014-03-10  610  static int rdma_cancelled(struct p9_client *client, struct p9_req_t *req)
931700d2 Simon Derr         2014-03-10  611  {
931700d2 Simon Derr         2014-03-10  612  	struct p9_trans_rdma *rdma = client->trans;
931700d2 Simon Derr         2014-03-10  613  	atomic_inc(&rdma->excess_rc);
931700d2 Simon Derr         2014-03-10  614  	return 0;
931700d2 Simon Derr         2014-03-10  615  }
931700d2 Simon Derr         2014-03-10  616  
f569d3ef Dominique Martinet 2015-01-09  617  static int p9_rdma_bind_privport(struct p9_trans_rdma *rdma)
f569d3ef Dominique Martinet 2015-01-09  618  {
f569d3ef Dominique Martinet 2015-01-09  619  	struct sockaddr_in cl = {
f569d3ef Dominique Martinet 2015-01-09  620  		.sin_family = AF_INET,
f569d3ef Dominique Martinet 2015-01-09  621  		.sin_addr.s_addr = htonl(INADDR_ANY),
f569d3ef Dominique Martinet 2015-01-09  622  	};
f569d3ef Dominique Martinet 2015-01-09  623  	int port, err = -EINVAL;
f569d3ef Dominique Martinet 2015-01-09  624  
f569d3ef Dominique Martinet 2015-01-09  625  	for (port = P9_DEF_MAX_RESVPORT; port >= P9_DEF_MIN_RESVPORT; port--) {
f569d3ef Dominique Martinet 2015-01-09  626  		cl.sin_port = htons((ushort)port);
f569d3ef Dominique Martinet 2015-01-09 @627  		err = rdma_bind_addr(rdma->cm_id, (struct sockaddr *)&cl);
f569d3ef Dominique Martinet 2015-01-09  628  		if (err != -EADDRINUSE)
f569d3ef Dominique Martinet 2015-01-09  629  			break;
f569d3ef Dominique Martinet 2015-01-09  630  	}
f569d3ef Dominique Martinet 2015-01-09  631  	return err;
f569d3ef Dominique Martinet 2015-01-09  632  }
f569d3ef Dominique Martinet 2015-01-09  633  
fc79d4b1 Tom Tucker         2008-10-22  634  /**
fc79d4b1 Tom Tucker         2008-10-22  635   * trans_create_rdma - Transport method for creating atransport instance
fc79d4b1 Tom Tucker         2008-10-22  636   * @client: client instance
fc79d4b1 Tom Tucker         2008-10-22  637   * @addr: IP address string
fc79d4b1 Tom Tucker         2008-10-22  638   * @args: Mount options string
fc79d4b1 Tom Tucker         2008-10-22  639   */
fc79d4b1 Tom Tucker         2008-10-22  640  static int
fc79d4b1 Tom Tucker         2008-10-22  641  rdma_create_trans(struct p9_client *client, const char *addr, char *args)
fc79d4b1 Tom Tucker         2008-10-22  642  {
fc79d4b1 Tom Tucker         2008-10-22  643  	int err;
fc79d4b1 Tom Tucker         2008-10-22  644  	struct p9_rdma_opts opts;
fc79d4b1 Tom Tucker         2008-10-22  645  	struct p9_trans_rdma *rdma;
fc79d4b1 Tom Tucker         2008-10-22  646  	struct rdma_conn_param conn_param;
fc79d4b1 Tom Tucker         2008-10-22  647  	struct ib_qp_init_attr qp_attr;
fc79d4b1 Tom Tucker         2008-10-22  648  
fc79d4b1 Tom Tucker         2008-10-22  649  	/* Parse the transport specific mount options */
fc79d4b1 Tom Tucker         2008-10-22  650  	err = parse_opts(args, &opts);
fc79d4b1 Tom Tucker         2008-10-22  651  	if (err < 0)
fc79d4b1 Tom Tucker         2008-10-22  652  		return err;
fc79d4b1 Tom Tucker         2008-10-22  653  
fc79d4b1 Tom Tucker         2008-10-22  654  	/* Create and initialize the RDMA transport structure */
fc79d4b1 Tom Tucker         2008-10-22  655  	rdma = alloc_rdma(&opts);
fc79d4b1 Tom Tucker         2008-10-22  656  	if (!rdma)
fc79d4b1 Tom Tucker         2008-10-22  657  		return -ENOMEM;
fc79d4b1 Tom Tucker         2008-10-22  658  
fc79d4b1 Tom Tucker         2008-10-22  659  	/* Create the RDMA CM ID */
fa20105e Guy Shapiro        2015-10-22 @660  	rdma->cm_id = rdma_create_id(&init_net, p9_cm_event_handler, client,
fa20105e Guy Shapiro        2015-10-22  661  				     RDMA_PS_TCP, IB_QPT_RC);
fc79d4b1 Tom Tucker         2008-10-22  662  	if (IS_ERR(rdma->cm_id))
fc79d4b1 Tom Tucker         2008-10-22  663  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  664  
517ac45a Tom Tucker         2008-10-23  665  	/* Associate the client with the transport */
517ac45a Tom Tucker         2008-10-23  666  	client->trans = rdma;
517ac45a Tom Tucker         2008-10-23  667  
f569d3ef Dominique Martinet 2015-01-09  668  	/* Bind to a privileged port if we need to */
f569d3ef Dominique Martinet 2015-01-09  669  	if (opts.privport) {
f569d3ef Dominique Martinet 2015-01-09  670  		err = p9_rdma_bind_privport(rdma);
f569d3ef Dominique Martinet 2015-01-09  671  		if (err < 0) {
f569d3ef Dominique Martinet 2015-01-09  672  			pr_err("%s (%d): problem binding to privport: %d\n",
f569d3ef Dominique Martinet 2015-01-09  673  			       __func__, task_pid_nr(current), -err);
f569d3ef Dominique Martinet 2015-01-09  674  			goto error;
f569d3ef Dominique Martinet 2015-01-09  675  		}
f569d3ef Dominique Martinet 2015-01-09  676  	}
f569d3ef Dominique Martinet 2015-01-09  677  
fc79d4b1 Tom Tucker         2008-10-22  678  	/* Resolve the server's address */
fc79d4b1 Tom Tucker         2008-10-22  679  	rdma->addr.sin_family = AF_INET;
fc79d4b1 Tom Tucker         2008-10-22  680  	rdma->addr.sin_addr.s_addr = in_aton(addr);
fc79d4b1 Tom Tucker         2008-10-22  681  	rdma->addr.sin_port = htons(opts.port);
fc79d4b1 Tom Tucker         2008-10-22 @682  	err = rdma_resolve_addr(rdma->cm_id, NULL,
fc79d4b1 Tom Tucker         2008-10-22  683  				(struct sockaddr *)&rdma->addr,
fc79d4b1 Tom Tucker         2008-10-22  684  				rdma->timeout);
fc79d4b1 Tom Tucker         2008-10-22  685  	if (err)
fc79d4b1 Tom Tucker         2008-10-22  686  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  687  	err = wait_for_completion_interruptible(&rdma->cm_done);
fc79d4b1 Tom Tucker         2008-10-22  688  	if (err || (rdma->state != P9_RDMA_ADDR_RESOLVED))
fc79d4b1 Tom Tucker         2008-10-22  689  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  690  
fc79d4b1 Tom Tucker         2008-10-22  691  	/* Resolve the route to the server */
fc79d4b1 Tom Tucker         2008-10-22 @692  	err = rdma_resolve_route(rdma->cm_id, rdma->timeout);
fc79d4b1 Tom Tucker         2008-10-22  693  	if (err)
fc79d4b1 Tom Tucker         2008-10-22  694  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  695  	err = wait_for_completion_interruptible(&rdma->cm_done);
fc79d4b1 Tom Tucker         2008-10-22  696  	if (err || (rdma->state != P9_RDMA_ROUTE_RESOLVED))
fc79d4b1 Tom Tucker         2008-10-22  697  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  698  
fc79d4b1 Tom Tucker         2008-10-22  699  	/* Create the Completion Queue */
7cf20fc6 Christoph Hellwig  2016-03-03 @700  	rdma->cq = ib_alloc_cq(rdma->cm_id->device, client,
7cf20fc6 Christoph Hellwig  2016-03-03  701  			opts.sq_depth + opts.rq_depth + 1,
7cf20fc6 Christoph Hellwig  2016-03-03  702  			0, IB_POLL_SOFTIRQ);
fc79d4b1 Tom Tucker         2008-10-22  703  	if (IS_ERR(rdma->cq))
fc79d4b1 Tom Tucker         2008-10-22  704  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  705  
fc79d4b1 Tom Tucker         2008-10-22  706  	/* Create the Protection Domain */
ed082d36 Christoph Hellwig  2016-09-05 @707  	rdma->pd = ib_alloc_pd(rdma->cm_id->device, 0);
fc79d4b1 Tom Tucker         2008-10-22  708  	if (IS_ERR(rdma->pd))
fc79d4b1 Tom Tucker         2008-10-22  709  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  710  
fc79d4b1 Tom Tucker         2008-10-22  711  	/* Create the Queue Pair */
fc79d4b1 Tom Tucker         2008-10-22  712  	memset(&qp_attr, 0, sizeof qp_attr);
fc79d4b1 Tom Tucker         2008-10-22  713  	qp_attr.event_handler = qp_event_handler;
fc79d4b1 Tom Tucker         2008-10-22  714  	qp_attr.qp_context = client;
fc79d4b1 Tom Tucker         2008-10-22  715  	qp_attr.cap.max_send_wr = opts.sq_depth;
fc79d4b1 Tom Tucker         2008-10-22  716  	qp_attr.cap.max_recv_wr = opts.rq_depth;
fc79d4b1 Tom Tucker         2008-10-22  717  	qp_attr.cap.max_send_sge = P9_RDMA_SEND_SGE;
fc79d4b1 Tom Tucker         2008-10-22  718  	qp_attr.cap.max_recv_sge = P9_RDMA_RECV_SGE;
fc79d4b1 Tom Tucker         2008-10-22  719  	qp_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
fc79d4b1 Tom Tucker         2008-10-22  720  	qp_attr.qp_type = IB_QPT_RC;
fc79d4b1 Tom Tucker         2008-10-22  721  	qp_attr.send_cq = rdma->cq;
fc79d4b1 Tom Tucker         2008-10-22  722  	qp_attr.recv_cq = rdma->cq;
fc79d4b1 Tom Tucker         2008-10-22 @723  	err = rdma_create_qp(rdma->cm_id, rdma->pd, &qp_attr);
fc79d4b1 Tom Tucker         2008-10-22  724  	if (err)
fc79d4b1 Tom Tucker         2008-10-22  725  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  726  	rdma->qp = rdma->cm_id->qp;
fc79d4b1 Tom Tucker         2008-10-22  727  
fc79d4b1 Tom Tucker         2008-10-22  728  	/* Request a connection */
fc79d4b1 Tom Tucker         2008-10-22  729  	memset(&conn_param, 0, sizeof(conn_param));
fc79d4b1 Tom Tucker         2008-10-22  730  	conn_param.private_data = NULL;
fc79d4b1 Tom Tucker         2008-10-22  731  	conn_param.private_data_len = 0;
fc79d4b1 Tom Tucker         2008-10-22  732  	conn_param.responder_resources = P9_RDMA_IRD;
fc79d4b1 Tom Tucker         2008-10-22  733  	conn_param.initiator_depth = P9_RDMA_ORD;
fc79d4b1 Tom Tucker         2008-10-22 @734  	err = rdma_connect(rdma->cm_id, &conn_param);
fc79d4b1 Tom Tucker         2008-10-22  735  	if (err)
fc79d4b1 Tom Tucker         2008-10-22  736  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  737  	err = wait_for_completion_interruptible(&rdma->cm_done);
fc79d4b1 Tom Tucker         2008-10-22  738  	if (err || (rdma->state != P9_RDMA_CONNECTED))
fc79d4b1 Tom Tucker         2008-10-22  739  		goto error;
fc79d4b1 Tom Tucker         2008-10-22  740  
fc79d4b1 Tom Tucker         2008-10-22  741  	client->status = Connected;
fc79d4b1 Tom Tucker         2008-10-22  742  
fc79d4b1 Tom Tucker         2008-10-22  743  	return 0;
fc79d4b1 Tom Tucker         2008-10-22  744  
fc79d4b1 Tom Tucker         2008-10-22  745  error:
fc79d4b1 Tom Tucker         2008-10-22  746  	rdma_destroy_trans(rdma);
fc79d4b1 Tom Tucker         2008-10-22  747  	return -ENOTCONN;
fc79d4b1 Tom Tucker         2008-10-22  748  }
fc79d4b1 Tom Tucker         2008-10-22  749  

:::::: The code at line 551 was first introduced by commit
:::::: fc79d4b104f0eb8c2a7242150eaf8756ced4c344 9p: rdma: RDMA Transport Support for 9P

:::::: TO: Tom Tucker <tom@opengridcomputing.com>
:::::: CC: Eric Van Hensbergen <ericvh@opteron.(none)>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gBBFr7Ir9EOA20Yy--
