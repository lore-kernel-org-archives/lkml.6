Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48q1rUPl4yqx3LtUuviqPcVPsBjRcS6NyGWgc9IP3QuIuNZdDjhEtPN0fR4gXsvs10s7E4I
ARC-Seal: i=1; a=rsa-sha256; t=1523399213; cv=none;
        d=google.com; s=arc-20160816;
        b=BHuVWxzAJvP4OGdxSgpCGhWXk6ryOHF/3PzMpcIONQAUiopSoHQ9xTSGuhnblcy3Vl
         s5JlasVHlzCXfmjZF7Bkv9HR8bNGhsqcYWca6f5JSSxaKc550481UpOeHIzuePQ6THKn
         0KBnI33k0/nGOTy5zrCtw1vsGk1jiacTIySBaBVF7LVeTbqUmltONJaMxqQaPk5ckdtZ
         diqMouC7ZUqyxkKq8rU+auo4gFJy7WLmPAJB3S0KKpxHXNQZ+pqW67z297P/Ashh+hEX
         3L2bKwaLaMDLUyBZvfVxzXZBBphZvdClnMdb2F7wEczHYoncfzQyuha/gm6VYdMUSwyT
         pKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qdpYN8eG4ECDyZUdpfefGiGurB9MX7TW8xpZodwympE=;
        b=oNDVXBgmPY1TWOcmskuVZvbawZRZKct3SBGXlJ2ghR2Izl/CLHI4G+lCIQti0YPfGb
         LN3CRO2rRwF+yH64uXsDCGzFQITxxZu2iVBWZrUy/M9EnrBqHqaQkvHoZpNJw9jwge7I
         kWl0Y+GWQsewUTii0996HgoQ5f7eoen4lHTqhgp+kP3dBVehUUJo2CTTXqJWonFm14Jj
         5Kb0HrCCwslIZevOeqZ6glg0wBqAU+o4ty+z9UK6sxKvwfmXUsJIBdN2NYKje/FwHfLq
         9rAAYRimE0kGgI/bm1REZdtADMGoeJENRDnLBniYCXnjEIGd6xY+ueF+SUZ/L0NNERc1
         1T0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 027/168] selftests/net: fix bugs in address and port initialization
Date: Wed, 11 Apr 2018 00:22:49 +0200
Message-Id: <20180410212801.355499320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399853915126118?=
X-GMAIL-MSGID: =?utf-8?q?1597399853915126118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>


[ Upstream commit d36f45e5b46723cf2d4147173e18c52d4143176d ]

Address/port initialization should work correctly regardless
of the order in which command line arguments are supplied,
E.g, cfg_port should be used to connect to the remote host
even if it is processed after -D, src/dst address initialization
should not require that [-4|-6] be specified before
the -S or -D args, receiver should be able to bind to *.<cfg_port>

Achieve this by making sure that the address/port structures
are initialized after all command line options are parsed.

Store cfg_port in host-byte order, and use htons()
to set up the sin_port/sin6_port before bind/connect,
so that the network system calls get the correct values
in network-byte order.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/msg_zerocopy.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -259,22 +259,28 @@ static int setup_ip6h(struct ipv6hdr *ip
 	return sizeof(*ip6h);
 }
 
-static void setup_sockaddr(int domain, const char *str_addr, void *sockaddr)
+
+static void setup_sockaddr(int domain, const char *str_addr,
+			   struct sockaddr_storage *sockaddr)
 {
 	struct sockaddr_in6 *addr6 = (void *) sockaddr;
 	struct sockaddr_in *addr4 = (void *) sockaddr;
 
 	switch (domain) {
 	case PF_INET:
+		memset(addr4, 0, sizeof(*addr4));
 		addr4->sin_family = AF_INET;
 		addr4->sin_port = htons(cfg_port);
-		if (inet_pton(AF_INET, str_addr, &(addr4->sin_addr)) != 1)
+		if (str_addr &&
+		    inet_pton(AF_INET, str_addr, &(addr4->sin_addr)) != 1)
 			error(1, 0, "ipv4 parse error: %s", str_addr);
 		break;
 	case PF_INET6:
+		memset(addr6, 0, sizeof(*addr6));
 		addr6->sin6_family = AF_INET6;
 		addr6->sin6_port = htons(cfg_port);
-		if (inet_pton(AF_INET6, str_addr, &(addr6->sin6_addr)) != 1)
+		if (str_addr &&
+		    inet_pton(AF_INET6, str_addr, &(addr6->sin6_addr)) != 1)
 			error(1, 0, "ipv6 parse error: %s", str_addr);
 		break;
 	default:
@@ -603,6 +609,7 @@ static void parse_opts(int argc, char **
 				    sizeof(struct tcphdr) -
 				    40 /* max tcp options */;
 	int c;
+	char *daddr = NULL, *saddr = NULL;
 
 	cfg_payload_len = max_payload_len;
 
@@ -627,7 +634,7 @@ static void parse_opts(int argc, char **
 			cfg_cpu = strtol(optarg, NULL, 0);
 			break;
 		case 'D':
-			setup_sockaddr(cfg_family, optarg, &cfg_dst_addr);
+			daddr = optarg;
 			break;
 		case 'i':
 			cfg_ifindex = if_nametoindex(optarg);
@@ -638,7 +645,7 @@ static void parse_opts(int argc, char **
 			cfg_cork_mixed = true;
 			break;
 		case 'p':
-			cfg_port = htons(strtoul(optarg, NULL, 0));
+			cfg_port = strtoul(optarg, NULL, 0);
 			break;
 		case 'r':
 			cfg_rx = true;
@@ -647,7 +654,7 @@ static void parse_opts(int argc, char **
 			cfg_payload_len = strtoul(optarg, NULL, 0);
 			break;
 		case 'S':
-			setup_sockaddr(cfg_family, optarg, &cfg_src_addr);
+			saddr = optarg;
 			break;
 		case 't':
 			cfg_runtime_ms = 200 + strtoul(optarg, NULL, 10) * 1000;
@@ -660,6 +667,8 @@ static void parse_opts(int argc, char **
 			break;
 		}
 	}
+	setup_sockaddr(cfg_family, daddr, &cfg_dst_addr);
+	setup_sockaddr(cfg_family, saddr, &cfg_src_addr);
 
 	if (cfg_payload_len > max_payload_len)
 		error(1, 0, "-s: payload exceeds max (%d)", max_payload_len);
